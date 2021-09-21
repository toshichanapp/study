# IP制限

## アドレス種類
- ネットワークアドレス
  - ネットワークを示す
- IPアドレス
  - プライベート
  - グローバル

このIPアドレスがネットワークに所属しているかを調べる

## HTTP_X_FORWARDED_FOR
ロードバランサなどの機器を経由して
Webサーバに接続するクライアントの送信元IPアドレスを特定する際のデファクトスタンダード

リクエストが複数のプロキシを通過する場合、X-Forwarded-For リクエストヘッダー内の clientIPAddress の後に、リクエストがロードバランサーに達するまでにリクエストが通過したすべてのプロキシの IP アドレスが順に記載されます。したがって、右端の IP アドレスは最新のプロキシの IP アドレスで、左端の IP アドレスは発信元クライアントの IP アドレスです。このような場合、X-Forwarded-For リクエストヘッダーは次の形式になります。

[HTTP ヘッダーおよび クラシックロードバランサー - Elastic Load Balancing](http://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/classic/x-forwarded-headers.html)


## ソース
```
 request.headers.env['HTTP_X_FORWARDED_FOR']&.split(", ")&.[](0)
```
カンマ区切りで複数のIPが返ってくる
```
X-Forwarded-For: OriginatingClientIPAddress, proxy1-IPAddress, proxy2-IPAddress
```
最初の値がIP

## 許可するネットワークアドレス
`123.45.678.90/32`のようにスラッシュが入ってるものが
ネットワークアドレス
スラッシュ表記 -> マスク
```
 IPAddr.new("192.168.2.0/24")
```
のようにネットワークアドレスを使って作成したインスタンス

`include?(other)`で対象のアドレスがそのネットワークに含まれるかを調べる必要がある

### IPAddrクラスを使って
[class IPAddr (Ruby 2.4.0)](https://docs.ruby-lang.org/ja/2.4.0/class/IPAddr.html)


## 参考引用元
[XFF�i X-Forwarded-For �j�Ƃ�](https://www.infraexpert.com/study/loadbalancer11.html)

## controller

  ```ruby
  before_action :allow_ip_address

  private

  def render_forbidden
    render json: '', status: :forbidden
  end

  def allow_ip_address
    return true if allowed_ip_address?

    render_forbidden
  end

  def allowed_ip_address?
    return true if Rails.env.test? || Rails.env.development?

    accepatable_ips = []
    accepatable_ips.any? { |ip| IPAddr.new(ip).include?(request.remote_ip) }
  end
```

## rspec
IPを変えてrequestを投げたい

```ruby
subject{ get _path, params: { }, headers: { "REMOTE_ADDR" => remote_ip } }
```
