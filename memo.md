# APIからファイルをダウンロードする

## backend側
rails
ActionController::APIを継承したコントローラの場合

```ruby
render json: { data: Base64.strict_encode64(pdf_object),
                   filename: 'file_name' }
```

## frontend側
```javascript
const linkSource = `data:application/pdf;base64,${response.data}`
const fileName = response.filename
const downloadLinkElement = document.createElement('a')
downloadLinkElement.download = fileName
downloadLinkElement.href = linkSource
downloadLinkElement.click()
```

# request spec
アクション	200系	400系	500系
create	201	400, 401, 403	500
index	200	401, 403	任意
show	200	401, 403, 404★	任意
update	200	400, 401, 403, 404★	500
delete	200	401, 403, 404★	500
★：URL指定のid以外でレコードのfindに制約がかかる場合は「idに対応するレコードが存在しない」「idに対応するレコードは存在するが制約により見つからない」の両方が必須


### httpサーバー
https://inokara.hateblo.jp/entry/2015/06/21/225112

```
if(process.env.CIRCLE_BRANCH === 'master') {}
ruby -run -e httpd . -p 8000

```
## プロセスサブスティチューション
別リポの似たようなファイルのdiffの確認

```
diff <(cd <repo_name>; git show <branch_name>:<file_name>) <(cd <repo_name2>; git show <branch_name>:<file_name>)
ml)
```

## ログをs3からダウンロード
aws s3 cp --recursive s3://<パス> .

## ログから該当URLにアクセスしたIPを抽出 Pingdomからのアクセスを削除
```
cat */* | grep -e "GET <path>" -e "GET <path2>" -e "GET <path3>" | grep -v "Pingdom" | grep -o '"[0-9]*[.][0-9]*[.][0-9]*[.][0-9]*"$' | sort | uniq -c
```

## 静的なHTML（動的に構成しない、という意味。javascriptとかはあっても良い。）をファイル参照じゃなくてHTTP経由で見たい場合

そのファイルが有る場所で

```
ruby -run -e httpd . -p 8000
```
https://inokara.hateblo.jp/entry/2015/06/21/225112

```
$ php -S localhost:8000
```

## rubyでfile grep

```ruby
require 'time'

def raw_to_strf_txts
  arr = []
  File.foreach('target_date_raw.txt') do |str|
    arr << Time.parse(str).strftime('%d/%b/%Y')
  end
  arr
end

def to_file
  File.open("target_date_test.txt", "a") do |f|
    raw_to_strf_txts.each do |str|
      f.puts(str)
    end
  end
end

File.open('ans2.txt', 'a') do |f|
  raw_to_strf_txts.map do |str|
    f.puts str
    f.puts File.open('switchings_thanks.log', 'r').grep(/#{str}/)
  end
end
```


# jsonカラムの検索

## postgresql 演算子
```
表 9-39. JSON 演算子

演算子	右オペランド型	説明	例
->	int	JSON 配列要素取得	'[1,2,3]'::json->2
->	text	JSON オブジェクトフィールド取得	'{"a":1,"b":2}'::json->'b'
->>	int	JSON 配列要素をテキストとして取得	'[1,2,3]'::json->>2
->>	text	JSON オブジェクトフィールドをテキストとして取得	'{"a":1,"b":2}'::json->>'b'
#>	text配列	指定されたパスにてJSONオブジェクトを取得	'{"a":[1,2,3],"b":[4,5,6]}'::json#>'{a,2}'
#>>	text配列	指定されたパスにてJSONオブジェクトをテキストとして取得	'{"a":[1,2,3],"b":[4,5,6]}'::json#>>'{a,2}'

```
https://www.postgresql.jp/document/9.3/html/functions-json.html#FUNCTIONS-JSON-OP-TABLE

## jsonカラムの中のjson
Model.where("json_column->'inner_json_column'->>'json_key' in (?)", target_keys)


## jsonカラムの中の配列の中のハッシュ
Model.where("json_column->'inner_json_column'->'inner_hash'->0->>'key' in (?)", target_keys)


