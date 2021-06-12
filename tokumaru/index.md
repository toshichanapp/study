# 徳丸試験
[IPA安全なウェブサイトの作り方」
](https://www.ipa.go.jp/files/000017316.pdf)

## 攻撃の名前を覚える
１） SQL インジェクション
２） OS コマンド・インジェクション
３） パス名パラメータの未チェック／ディレクトリ・トラバーサル
４） セッション管理の不備
５） クロスサイト・スクリプティング
６） CSRF（クロスサイト・リクエスト・フォージェリ）
７） HTTP ヘッダ・インジェクション
８） メールヘッダ・インジェクション
９） クリックジャッキング
１０）バッファオーバーフロー
１１）アクセス制御や認可制御の欠落

## 対策
[徳丸試験（ウェブ・セキュリティ基礎試験）の試験情報と勉強方法 - Qiita](https://qiita.com/sano1202/items/a3d451bedd3371e4850b)

## ３大攻撃
- XSS
- SQLインジェクション
- CSRF

### XSS

#### 原因
#### 影響
- cookie
- session_id

-> セッションハイジャック

ログインして、プロフィール画面などのhtmlを取得して個人情報引っこ抜ける

#### 対策

### SQLインジェクション
#### 概要
- ユーザの入力からSQLを組み立てる
- railsだとwhereメソッドでSQLにparamsをそのまま突っ込んだりする

bad
```ruby
where("campaign->>'name' like '%#{@params[:campaign_name]}%'")
```

better
```ruby
where("campaign->>'name' like ?", "%#{sanitize_sql_like(@params[:campaign_name])}%" )
```

#### 対策
- ユーザの入力を信じない
- サニタイズする


### CSRF

## 大切なこと
[ウェブ・セキュリティ基礎試験(徳丸基礎試験）の模擬試験問題](https://www.slideshare.net/ockeghem/tokumaru-basic)

• 基礎試験はPHP等の特定言語には依存しません – JavaScriptに関する問題は出ます
• 徳丸本7章 脆弱性診断入門からは出題されません
• とても基礎的な問題ですが、それでも意外に点数がばらけます（経験談）
• ウェブセキュリティの基礎が把握できているかを確認するのに良いと思います

## railsのセキュリティガイド
[Rails セキュリティガイド - Railsガイド](https://railsguides.jp/security.html)
