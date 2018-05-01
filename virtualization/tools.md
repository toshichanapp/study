# 仮想化ツール
## Bootstraping -OSの起動
- OSインストール
- 仮想環境の設定
- ネットワーク構成の設定
- 仮想化ソフトウェアと構成管理ソフトウェアのラッパー

## Configuration -OS、ミドルウェアの設定
- 構成管理ソフトウェア
- OSの設定(セキュリティ・サービス起動)
- ミドルウェア(各種サーバ)のインストール・設定

## Orchestration -サーバ管理
- アプリケーションのデプロイ
- サーバ群のオーケストレーション

|||
|:--|
|Bootstraping|- KickStart <br> - VAGRANT
|Configuration|- Chef<br> - ANSIBLE <br>- puppet labs
|Orchestration|- Serf <br>- Capistrano <br>- Kubernetes


### Chef
- 物理、仮想、クラウドといった様々な大きさのインフラに対して、サーバっやアプリケーションの展開を容易にするための自動化フレームワークです
- メリット：サーバの中身をコードで作れる


#### VB設定して、Vagrant設定して、Chef設定して・・・面倒くさいね


### Docker
- LinuxカーネルのlibcontainerというLinuxコンテナ技術　と特殊なファイルシステムを利用してコンテナ型の仮想化を行う
- お手軽に欲しいソフトを仮想化する
- メリット楽
- デメリット　導入コスト

** Dockerを動かすにはLinuxが必要
ー＞くっつけたのが　Docker for mac /windows
