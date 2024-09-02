---
title: Edge のよくあるご質問
date: 2023-8-14
tags: 
  - Microsoft Edge
  - Edge
  - Microsoft WebView2 Runtime
  - WebView2
---

みなさんこんにちは。日本マイクロソフトの IE/Edge サポートチームです。

皆様からいただく Edge に関するよくある質問についてこちらにまとめました。

## 目次<!-- omit in toc -->
- [Edge バージョン 128.0.2739.42 以降において お気に入りの復元 は行えなくなりました](#edge-%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3-1280273942-%E4%BB%A5%E9%99%8D%E3%81%AB%E3%81%8A%E3%81%84%E3%81%A6-%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%E3%81%AE%E5%BE%A9%E5%85%83-%E3%81%AF%E8%A1%8C%E3%81%88%E3%81%AA%E3%81%8F%E3%81%AA%E3%82%8A%E3%81%BE%E3%81%97%E3%81%9F)
- [Edge のバージョンを Edge の UI 以外でコマンドライン等で確認する方法はありますか](#edge-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%82%92-edge-%E3%81%AE-ui-%E4%BB%A5%E5%A4%96%E3%81%A7%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%83%A9%E3%82%A4%E3%83%B3%E7%AD%89%E3%81%A7%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95%E3%81%AF%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99%E3%81%8B)
  - [UI 以外での確認方法について](#ui-%E4%BB%A5%E5%A4%96%E3%81%A7%E3%81%AE%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
  - [レジストリで確認する方法について](#%E3%83%AC%E3%82%B8%E3%82%B9%E3%83%88%E3%83%AA%E3%81%A7%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [Edge のバージョンと WebView2 Runtime のバージョンを揃える必要性はありますか](#edge-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%81%A8-webview2-runtime-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%82%92%E6%8F%83%E3%81%88%E3%82%8B%E5%BF%85%E8%A6%81%E6%80%A7%E3%81%AF%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99%E3%81%8B)


## Edge バージョン 128.0.2739.42 以降において お気に入りの復元 は行えなくなりました
***

以下の画像のように Edge 127.0.2651.105 においてはお気に入りのアイコンをクリックすると、削除したお気に入りの設定を復元するためのビンマークがございました。

![Edge 127.0.2651.105 でのお気に入りの復元の設定値](./edge-faq/edge-faq_2024-09-03-01-13-53.png)

こちらは Edge 128.0.2739.42 以降においてはビンマークがなくなりました。

![Edge 128.0.2739.42 でのお気に入りの復元の設定値](./edge-faq/edge-faq_2024-09-03-01-17-31.png)

お気に入りの設定を保持したい場合については [ManagedFavorites](https://learn.microsoft.com/ja-jp/deployedge/microsoft-edge-policies#managedfavorites) のご利用をご検討いただけますと幸いです。

その他にもお気に入りのインポートやエクスポートの機能もございます。詳細は [Microsoft Edge でお気に入りをインポートする](https://support.microsoft.com/ja-jp/microsoft-edge/microsoft-edge-%E3%81%A7%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%E3%82%92%E3%82%A4%E3%83%B3%E3%83%9D%E3%83%BC%E3%83%88%E3%81%99%E3%82%8B-278afd65-2294-9134-005a-ce7b48d868e1#:~:text=Microsoft%20Edge%20%E3%82%92%E9%96%8B%E3%81%8D%E3%80%81%20%5B%E8%A8%AD%E5%AE%9A%E3%81%AA%E3%81%A9%5D%20%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%BE%E3%81%99%E3%80%82%20%5B%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%5D%20%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%BE%E3%81%99%E3%80%82%20%5B%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%5D,%5B%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%E3%81%AE%E3%82%A4%E3%83%B3%E3%83%9D%E3%83%BC%E3%83%88%5D%20%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%BE%E3%81%99%E3%80%82%20%5B%E3%82%A4%E3%83%B3%E3%83%9D%E3%83%BC%E3%83%88%E5%85%83%5D%20%E3%83%A1%E3%83%8B%E3%83%A5%E3%83%BC%E3%81%A7%E3%80%81%20%5B%E3%81%8A%E6%B0%97%E3%81%AB%E5%85%A5%E3%82%8A%E3%81%BE%E3%81%9F%E3%81%AF%E3%83%96%E3%83%83%E3%82%AF%E3%83%9E%E3%83%BC%E3%82%AF%E3%81%AE%20HTML%20%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%5D%20%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%BE%E3%81%99%E3%80%82) をご確認ください。

拡張機能でもお気に入りを操作する API もございます。
詳細は [Microsoft Edge 拡張機能でサポートされている API](https://learn.microsoft.com/ja-jp/deployedge/microsoft-edge-policies#managedfavorites) の 「ブックマーク」をご参考いただけますと幸いです。



## Edge のバージョンを Edge の UI 以外でコマンドライン等で確認する方法はありますか
***

バージョンを Edge 上で確認したい場合は edge://version や edge://settings/help を見ることで判断が可能です。edge://settings/help は更新制御を行っていない場合、ページを開くと自動更新が始まります。

コントロール パネルで Edge のバージョンを確認いただくことも可能です。

注意点として、コントロール パネル上のバージョン表記と edge://version のバージョンが異なる状態になったという問い合わせをいただいたことがあります。

ご利用いただいている Edge の正しいバージョンは edge://version で表示されるものになります。 バージョン不一致が発生した場合、オンライン インストーラーまたはオフライン インストーラーを再度実行してください。そうすることで、コントロール パネル上での表示が正常になることが期待されます。

### UI 以外での確認方法について

コマンドラインや API 等で Edge のバージョンを取得したいというシナリオもあるかと思います。

システムインストールされた Edge を前提とした場合、コマンドラインから確認する方法があります。
(Windows 10 20H2 以降においては Edge はシステムインストールになります)

実際に利用する "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" から直接確認します。

PowerShell で下記コマンドを実行します。

入力:
```
(Get-Command "C:\Program Files (x86)\Microsoft\edge\Application\msedge.exe").Version
```

出力例:
```
Major  Minor  Build  Revision
-----  -----  -----  --------
115    0      1901   200
```

バージョンを取得したい場合は下記の例になります。

入力:
```
$version = (Get-Command "C:\Program Files (x86)\Microsoft\edge\Application\msedge.exe").Version
$versionString = "$($version.Major).$($version.Minor).$($version.Build).$($version.Revision)"
Write-Output $versionString
```

出力例:
```
115.0.1901.200
```

Get-Command については、弊社ドキュメント [Get-Command](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-command) をご確認ください。

### レジストリで確認する方法について

コントロール パネルで表示される Edge のバージョンは特定のレジストリを参照しています。

通常、オンライン インストーラーやオフライン インストーラーによるインストールが正常に終了した場合、当該のレジストリが更新されます。ただし、状況によっては正常に更新されない場合もあります。

そのため、 <span style="color: red; ">**レジストリに正常なバージョンが書き込まれることを保証していません。**</span>こうしたレジストリの値を利用するアプリケーションを開発されている場合はご注意ください。

インストールされている Edge のバージョンの確認については edge://version 等による UI での確認または、msedge.exe 自体を PowerShell 等で確認する方法がより適切であるとご理解ください。

## Edge のバージョンと WebView2 Runtime のバージョンを揃える必要性はありますか
***

こちらもよくいただく質問になりますが、Edge と WebView2 Runtime は開発スケジュールは同様ですが、相互に依存関係はありません。

Edge は WebView2 Runtime に関係なく動作し、その逆に WebView2 アプリケーションは Edge に関係なく動作し、WebView2 Runtime に依存します。

WebView2 の詳細については、弊社ブログの [WebView2 と WebView2 Runtime と WebView2 SDK はどのような違いがありますか](https://jpdsi.github.io/blog/internet-explorer-microsoft-edge/webview2-faq/#WebView2-%E3%81%A8-WebView2-Runtime-%E3%81%A8-WebView2-SDK-%E3%81%AF%E3%81%A9%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E9%81%95%E3%81%84%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99%E3%81%8B) をご確認ください。


Edge のバージョンは、弊社ブログの [Edge のバージョンの読み方について](https://jpdsi.github.io/blog/internet-explorer-microsoft-edge/how-and-why-to-update-edge/#Edge-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%81%AE%E8%AA%AD%E3%81%BF%E6%96%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6) で紹介しています。

> Edge のバージョン 100.0.1185.44 を例にして考えますと、メジャー バージョンは 100, マイナーバージョンは 0, ビルド バージョンは 1185, パッチ バージョンは 44 になります。

Edge も WebView2 の同じ開発スケジュールで提供されているため、メジャー バージョンが更新されるタイミングは似ています。

ただし、相互に依存関係はないため、パッチ バージョンが同じになる場合、異なる場合もあります。パッチ バージョンが異なるからといって、問題はありませんのでご安心ください。