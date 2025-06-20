---
title: IIS の調査に必要な通信系のログ情報について
date: 2020-01-21
tags: 
  - Internet Information Services
  - ログ採取
---

こんにちは。
 
IIS サポート チームです！
 
以前、IIS 上でのトラブル シューティングに役立つ 4 つのログの採取方法について以下の記事を書いてますが、現象の性質によってはこの 4 つのログ + α で調査の前進が見込まれるログがございます。

　IIS の調査に必要な基本的なログ情報について
　https://microsoft.github.io/jpwebapps/web-apps/LogCollection1/

今回は、IIS の通信に関する現象の調査に役立つログをご紹介いたします。
 
1. **失敗した要求トレース（事前準備が必要）**
2. **ネットワーク トレース（現象再現前に、OS 標準のコマンドにて実行）**

通信に関する現象と言っても多岐にわたるのですが、以下の様な現象の場合には通信に関する現象として捉えて問題はないと言えますので、「もしかしてクライアントとサーバー間の通信に問題があるのかも」と疑われるような場合に有効なログとなります。
 
- **IIS にアクセスしたクライアントがエラー ページを表示する**
- **IIS へのアクセスに成功はするものの、アクセスに時間を要する**
- **IIS ログにエラーを示す出力がある等**

また、再現性の有無により、採取出来るログが異なりますので、いずれのパターンに該当するかを確認した上でログを採取してください。
 
 ##### 再現性がある場合: 
 　　　**上記記事の 4 つのログ + 1. 失敗した要求トレース + 2. ネットワーク トレース**

 ##### 再現性がない場合:
 　　　**上記記事の 4 つのログ + 1. 失敗した要求トレース**
 
 
---------------


 # <u>1. 失敗した要求トレース</u>
採取手順を含む、このログについては以下の公開情報に整理されております。
一言で言うと、後述する「ネットワーク トレース」とは異なり、事前に構成することで、IIS 上で失敗した通信について記録しておいてくれるログです。
 
　Troubleshooting Failed Requests Using Tracing in IIS 8.5
　https://docs.microsoft.com/en-us/iis/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis-85
 
　Troubleshooting IIS request performance slowness issues using FREB tracing
　https://blogs.msdn.microsoft.com/docast/2016/04/28/troubleshooting-iis-request-performance-slowness-issues-using-freb-tracing/
 
　FREB | Failed Requests Tracing in IIS 7
　https://blogs.msdn.microsoft.com/amol/2009/04/01/freb-failed-requests-tracing-in-iis-7/
 
このログは、事前に構成しておくことで、現象発生時にログが出力されますので、問題が発生していない場合でも、これを構成しておくことで仮に将来通信に関する現象が発生した時に、このログを採取して解析することで原因究明につなげられます。
 
## Windows Server での事前準備 (1 ~ 3)
※文面の都合上、画面ショットの貼り付けはいたしませんが、上記に紹介したリンクでも同様の手順 + 画面ショットがございますのでご参照ください。
 
### 事前準備 1
**※ IIS の再起動が発生します OS の再起動は必要ありません**
 　**[Web サーバー (IIS)] の役割サービス "トレース" がインストールされていない場合、以下の手順でインストールします。**

1. サーバー マネージャーを開きます
2. サーバー マネージャー のツリー表示で、[役割] を展開して [Web サーバー (IIS)] をクリックします 
3. [Web サーバー (IIS)] ウィンドウで、[役割サービス] セクションまでスクロールして、[役割サービスの追加] をクリックします 
4. 役割サービスの追加ウィザードの [役割サービスの選択] ページで [トレース] を選択し、[次へ] をクリックします
5. [インストール オプションの確認] ページで [インストール] をクリックします 
6. [結果] ページで [閉じる] をクリックします
7. 管理者権限でコマンド プロンプトを起動し、以下のコマンドを実行します
   下記を実施することで、取得される失敗した要求トレース ログの 1 ファイルの最大サイズが 1MB になります

 
 > %windir%\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites "/[name='Default Web Site'].traceFailedRequestsLogging.maxLogFileSizeKB:1024" /commit:apphost 
 ※サイト名 (name= の値) として Default Web Site を指定していますが、ご利用の Web サイト名に適宜ご変更ください。

### 事前準備 2
以下の手順で、"失敗した要求トレース" を有効に設定します。
1. IIS マネージャーを開きます
2. [接続] ウィンドウで、対象の Web サイトを選択します 
3. [操作] ウィンドウで、[失敗した要求トレース...] をクリックします 
4. [Web サイトの失敗した要求トレース設定の編集] ダイアログ ボックスで、次のオプションを構成します


  - [有効にする] チェック ボックスをオンにして、トレースを有効にします
  - [ディレクトリ] ボックスで、失敗した要求のログ ファイルを格納する場所として既定値をそのまま使用するか、新しいディレクトリを入力します
  - [トレース ファイルの最大数] ボックスに、格納する失敗した要求トレース ファイルの数を入力します
  
**※ファイルは 1 リクエストにつき 1 ファイル作成されます。設定したファイル数を上限として、**
　**古いものから順に削除されるため、現象発生後に長い時間をおくと必要なファイルが削除される場合があります**

　**このため、同時アクセスがある場合にはそれを考慮した値を設定していただき、**
　**現象発生後には早い段階で [有効にする] チェックボックスを外し、キャプチャを停止いただければと存じます**

5. [OK] をクリックします
 
### 事前準備 3
以下の手順で、"失敗した要求トレースの規則" を作成します。
1. IIS マネージャーを開きます
2. [接続] ウィンドウで、対象の Web サイトを選択します
3. [機能] ウィンドウで、[失敗した要求トレースの規則] をダブルクリックします
4. [操作] ウィンドウで、[追加] をクリックします 
5. [失敗した要求トレース規則の追加] ウィザードの [トレースするコンテンツの指定] で、"すべてのコンテンツ (*)(A)" を選択し、[次へ] をクリックします
6. [トレース条件の定義] ページで、[トレース条件の定義] で、[状態コード] に 401.3-999 と入力、[所要時間（秒）] に 30 と入力して [次へ] をクリックします
7. [トレース プロバイダーの選択] ページで、既定値をそのまま使用し、[終了] をクリックします
 
## Windows Server での採取手順
現象再現後、以下に作成されるトレース ログすべてを採取します。
 
　%SystemDrive%\inetpub\logs\FailedReqLogFiles

 # <u>2. ネットワーク トレース</u>
このログについては、弊社でも多くの情報を公開しておりますが、一言で言うと、OS の標準機能の netsh コマンドを使用して現象発生時に通信ログを取得できるログです。

IIS 上で ARR を動かしている場合は、ARR は内部で winhttp というモジュールを使用して通信をしているため、このモジュールの動作もキャプチャすることが出来るように、"senario=InternetClient_dbg" というオプションを付与するとより多くの情報の解析が出来ます。

　Troubleshooting 502 Errors in ARR
　https://docs.microsoft.com/en-us/iis/extensions/troubleshooting-application-request-routing/troubleshooting-502-errors-in-arr

なお、このログは現象発生直前にコマンドを実行した上で、現象の再現を試み、現象発生後にコマンドを実行してログの採取を停止いたします。
つまり、再現性がある時に採取を試みますので、この点、上記「失敗した要求トレース」とは異なりますのでご注意ください。
 
## Windows Server での採取手順

1. 管理者権限でコマンド プロンプトを開きます 
2. 次のコマンドを実行し、キャプチャを開始します
 
　netsh trace start capture=yes maxSize=2000MB

3. 現象が発生する操作を行います
4. 次のコマンドを実行して、キャプチャを停止します (しばらく時間がかかります)
 
　netsh trace stop
 
5. 作成される cab と etl ファイルを採取します

今回は以上です。 それでは、また次回！

