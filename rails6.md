# ruby 2.4 -> 2.6
ALBのターゲットグループから外す

ec2-metadata # IP アドレスや instance ID を確認して、対象のインスタンスか指さし確認する

sudo yum remove gcc libstdc++48-devel
sudo yum install gcc72  gcc72-c++  libstdc++72

psql --version # インストールされている postgresql のバージョンを確認する
sudo yum install postgresql96-devel.x86_64 # postgresql 9.6 であれば、これを実行する
bundle install --without test

# 下記のコマンドを実行して、正常に応答することを確認する
curl -o - --header "X-Forwarded-Proto: https" http://localhost/


# rails 6

## precompileできない
```
 Crash Report log information --------------------------------------------
   See Crash Report log file under the one of following:                    
     * ~/Library/Logs/DiagnosticReports                                     
     * /Library/Logs/DiagnosticReports                                      
   for more details.                                                        
Don't forget to include the above Crash Report log file in bug reports.  
```

[Rails6でセグメンテーションエラーが発生する問題を解決した | 人と情報](https://www.tmp1024.com/articles/fix-rails-6-segmentation-error)

## undefined_method start_with? proc, regex
assets.rb
```
file_names = []
[File.join('app', 'assets', 'stylesheets'), File.join('app', 'assets', 'javascripts')].each do |dir|
  file_names += Dir.glob("#{dir}/**/*").select do |file_name|
    file_name =~ %r{(^|/)[^_][^/]+.(css|js|map)$}
  end.map do |file_name|
    file_name.gsub(/\.s?(css|js)$/, '.\1').gsub("#{dir}/", '').gsub(".css.css", '.css')
  end
end
Rails.application.config.assets.precompile += file_names

```

## undefined method exists for ActiveRecord_Relation
arel.exists
と明示することで解決


## use_transactional_fixtures
NoMethodError:
undefined method use_transactional_fixtures= for #<RSpec::ExampleGroups::Order_2::AssignVouchers::Nested:0x00007ffe1d640be0>
Did you mean?  use_transactional_tests=
use_transactional_tests
use_transactional_tests?

## DEPRECATION WARNING: Dangerous query method (method whose arguments are used as raw SQL) called with non-attribute argument(s):



##  Failure/Error: expect(response).to be_success
       expected #<ActionDispatch::TestResponse:0x00007fddc23a9268 @mon_mutex=#<Thread::Mutex:0x00007fddc23a9218>, @mo...ders:0x00007fddc23092b8 @req=#<ActionController::TestRequest:0x00007fddc23a93d0 ...>>, @variant=[]>> to respond to `success?`


[Rails 5.2 betaを使ったRSpec 実行時に be_success へされる非推奨警告 - koicの日記](http://koic.hatenablog.com/entry/deprecation-warning-success-predicate-is-deprecated-and-will-be-removed-in-rails6)

be_success -> be_successful

##  uninitialized constant ActionDispatch::ParamsParser

[Rails5.2でJSONパースエラーをJSON形式で返す - Qiita](https://qiita.com/ledsun/items/4e3431de080c97796817)


## .DEPRECATION WARNING: Class level methods will no longer inherit scoping from `compatible_for` in Rails 6.1. To continue using the scoped relation, pass it into the block directly. To instead access the full set of models, as Rails 6.1 will, use `Plan.unscoped`, or `Plan.default_scoped` if a model has default scopes. (called from block in <class:Plan> at /home/circleci/repo/rails/app/models/plan.rb:69)
## enumのkeyにeachが使えない


