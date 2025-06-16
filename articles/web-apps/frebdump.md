---
title: 失敗した要求トレースを契機とするメモリダンプ (FREBDump) の取得方法 について
date: 2021-05-27
tags: 
  - Internet Information Services
  - ログ採取
  - FREBDump
---

# FREBDump の取得方法について <!-- omit in toc -->

こんにちは。IIS サポート チームです！  

弊社にお問い合わせいただくお客様に、スムーズな解決をご提供するためにお役に立てる内容をご提供させていただきます。  
今回は IIS のワーカープロセス (w3wp.exe) のメモリダンプを取得する手法の一つ、FREBDump の手順についてご説明します。

## FREBDump とは <!-- omit in toc -->

FREBDump とは、失敗した要求トレース (通称: FREB) を契機として ProcDump を実行することを指します。

(なお FREBDump は正式名称ではございません。失敗した要求トレース が 英語で Failed Request Event Buffering (FREB) と呼ばれること、ProcDump の Dump から FREBDump と呼称しております。)

このログ取得のポイントは FREB の発火点によって ProcDump を制御するところにあります。

## FREBDump のメリット <!-- omit in toc -->

FREBDump でのダンプ採取のメリットは、ProcDump よりも柔軟なタイミングでのダンプの取得ができることです。  
例えば以下は ProcDump では難しいですが、 FREBDump では可能になります。

1) IIS サーバーが受け取ったリクエストで特定の時間以上になった場合にダンプを取る
2) 40X や 50X など、特定のエラーレスポンスで応答されたタイミングでダンプを取る

例えば、お客様から IIS サーバーが不定期にスローダウンし、リクエストのレスポンスが遅くなるといったお問い合わせをいただくことがございます。  
このような場合は 1) のように特定の時間でダンプを生成するように設定することで調査をすることができます。

## 目次 <!-- omit in toc -->

- [1. 前提条件](#1-%E5%89%8D%E6%8F%90%E6%9D%A1%E4%BB%B6)
  - [1.1. 事前に準備が必要なものについて](#11-%E4%BA%8B%E5%89%8D%E3%81%AB%E6%BA%96%E5%82%99%E3%81%8C%E5%BF%85%E8%A6%81%E3%81%AA%E3%82%82%E3%81%AE%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [2. FREBDump の設定手順](#2-FREBDump-%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%89%8B%E9%A0%86)
  - [2.1. FREB の有効化](#21-FREB-%E3%81%AE%E6%9C%89%E5%8A%B9%E5%8C%96)
  - [2.2. FREB の規則作成](#22-FREB-%E3%81%AE%E8%A6%8F%E5%89%87%E4%BD%9C%E6%88%90)
  - [2.3. ProcDump の設定](#23-ProcDump-%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [2.3.1. サーバーでの customActionEnable の設定](#231-%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%A7%E3%81%AE-customActionEnable-%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [2.3.2. ウェブサイト側での customActionExe などの設定](#232-%E3%82%A6%E3%82%A7%E3%83%96%E3%82%B5%E3%82%A4%E3%83%88%E5%81%B4%E3%81%A7%E3%81%AE-customActionExe-%E3%81%AA%E3%81%A9%E3%81%AE%E8%A8%AD%E5%AE%9A)
  - [2.4. FREBDump のアンインストール方法について](#24-FREBDump-%E3%81%AE%E3%82%A2%E3%83%B3%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [2.5. FREB の設定の削除について](#25-FREB-%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%81%AE%E5%89%8A%E9%99%A4%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [2.6. ProcDump の削除について](#26-ProcDump-%E3%81%AE%E5%89%8A%E9%99%A4%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [3. FREBDump の検証方法について](#3-FREBDump-%E3%81%AE%E6%A4%9C%E8%A8%BC%E6%96%B9%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [4. FREBDump の FAQ について](#4-FREBDump-%E3%81%AE-FAQ-%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

## 1. 前提条件

### 1.1. 事前に準備が必要なものについて

FREBDump の取得のためには以下がインストールされている必要がございます。

- 失敗した要求トレース (FREB) がインストールされていること
- ProcDump がインストールされていること

IIS Manager を起動し、中央のアイコンで、[IIS] - [失敗した要求トレース] が存在することを確認します。

もしこちらが存在しない場合は、失敗した要求トレース (FREB) のモジュールが存在しません。  
その場合、サーバー マネージャーの役割サービスの追加で、[Web サーバー] - [状態と診断] - [トレース] をインストールします。**インストールの際は、IIS の再起動が発生しますのでご注意ください。**

![FREB のインストールが必要な場合について](./frebdump/frebdump_2021-05-20-22-38-58.png)

## 2. FREBDump の設定手順

### 2.1. FREB の有効化

IIS マネージャーを起動し、[Web サイト] から現象が発生している <対象となるウェブサイト> を選択します。  

[操作] - [構成] - [失敗した要求トレース] をクリックします。  

[失敗した要求のトレースが、この Web サイトに対して有効になっていません。] という警告が表示される場合は、クリックしてログを有効にします。

![FREBの有効化の説明図1](./frebdump/frebdump_2021-05-20-00-53-50.png)

[操作] ウィンドウの [サイトのトレースの編集] をクリックし、[有効にする] にチェックがあることを確認してください。

![FREBの有効化の説明図2](./frebdump/frebdump_2021-05-18-02-00-38.png)

### 2.2. FREB の規則作成

[失敗した要求トレースの規則] - [操作] - [追加] をクリックします。

[トレースするコンテンツの指定] で、<トレースするコンテンツ>、  
[トレース条件の定義] で、<トレース条件の定義>、  
[トレース プロバイダーの選択] で、 <トレースプロバイダー> を設定し [終了] をクリックします。

![FREB の規則作成手順図](./frebdump/frebdump_2021-05-20-01-17-01.png)

### 2.3. ProcDump の設定

#### 2.3.1. サーバーでの customActionEnable の設定

IIS マネージャーの[接続] ウィンドウで、最上位に存在するサーバーの [構成エディター] をダブルクリックします。  
セクションで system.applicationHost/sites を選択します。

![構成エディターの選択図](./frebdump/frebdump_2021-05-20-20-55-37.png)

(コレクション) の行を選択し、右側にある [...] ボタンをクリックします。  
[コレクション エディター] 画面で、<対象となるウェブサイト> を選択します。  
プロパティより、[traceFailedRequestsLogging] を展開し、以下を設定します。

- [customActionsEnabled] : True  
- [maxLogFileSizeKB] : 1024

![サーバー側構成エディターの設定図](./frebdump/frebdump_2021-05-20-20-57-52.png)

コレクション エディター ウィンドウを閉じ、適用します。

![構成エディターの適用図](./frebdump/frebdump_2021-05-20-21-32-52.png)

#### 2.3.2. ウェブサイト側での customActionExe などの設定

サーバーを選択しましたが、次は <対象となるウェブサイト> を選択して、
サイトに存在する構成エディターを開きます。  
[場所] が <対象となるウェブサイト> Web.config であるを確認してください。  
[セクション] で  system.webServer/tracing/traceFailedRequests を選択します。  

![サイトの構成エディターの選択図](./frebdump/frebdump_2021-05-26-22-08-45.png)

(コレクション) の行を選択し、右側にある [...] ボタンをクリックします。  
[コレクション エディター] 画面で、path が * となっている行を選択し、
[プロパティ] ウィンドウの各項目に ProcDump の設定を行います。

以下それぞれを入力してください。

- [customActionExe] : \<インストールした ProcDump のパス\>
- [customActionParams] : \<ProcDump の引数\>
- [customActionTriggerLimit] : \<customActionExe の試行回数\>

※弊社から特に指示がない場合は以下の通りに行ってください。

- [customActionExe] : \<C:\Procdump\procdump.exe などのインストールした .exe のパス\>
- [customActionParams] : -accepteula -ma -s 30 -n 2 %1% \<C:\ProcDump\output などのダンプファイル保存場所\>
- [customActionTriggerLimit] : 2

![構成エディターによる ProcDump の設定図](./frebdump/frebdump_2021-05-20-22-30-14.png)

コレクション エディター ウィンドウを閉じます。
[操作] ウィンドウで、[適用] を選択します。

以上で設定は終了です。

### 2.4. FREBDump のアンインストール方法について

<対象となるウェブサイト> の構成エディタで設定した以下3つの値を削除します。

- customActionExe
- customActionParams
- customActionTriggerLimit

サーバーの構成エディタで設定した以下の設定を変更します

- customActionEnabled = True の設定を False

### 2.5. FREB の設定の削除について

FREB 自体を無効化する場合は、  
<対象となるウェブサイト> の 失敗した要求トレースの規則 を開き、作成した規則を選択し、削除 を押してください。

### 2.6. ProcDump の削除について

ProcDump はインストールしたフォルダごと削除いただくことでアンインストールできます。

## 3. FREBDump の検証方法について

こちらは [失敗した要求トレースを契機とするメモリダンプ (FREBDump) でよくいただくご質問について](https://microsoft.github.io/jpwebapps/web-apps/frebdump-faq/) をご確認ください。

## 4. FREBDump の FAQ について

こちらは [失敗した要求トレースを契機とするメモリダンプ (FREBDump) でよくいただくご質問について](https://microsoft.github.io/jpwebapps/web-apps/frebdump-faq/) をご確認ください。

<!-- 
また今回利用した 失敗した要求トレース(FREB)、ProcDump についての Q&A も合わせてご確認いただけますと幸いです。

- [失敗した要求トレース(FREB) についての Q&A][失敗した要求トレース(FREB) についてのQ&A]
- [ProcDump についての Q&A][ProcDump についての Q&A]

-->

以上の Q&A を確認したもののご不明点が解決しない場合は、私共サポートまでお問い合わせいただけますと大変幸いです。
