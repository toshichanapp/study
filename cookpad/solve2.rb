# ruby solve2.rb griffin vampire dragon troll medusa
require 'net/http'

# 自分より弱い奴らをメモ
@losers = Hash.new{ |hash, key| hash[key] = Set.new }
def battle(monster1, monster2)
  url = 'https://ob6la3c120.execute-api.ap-northeast-1.amazonaws.com/Prod/battle/'
  req_url = File.join(url,"#{monster1}+#{monster2}")
  res = {}
  # => {"winner":"dragon","loser":"griffin"}
end

battle('dragon', 'griffin')
@losers[res['winner']] << @losers['looser']

winnerはloserのlosersよりも強い
loserのlosersはwinnerより弱い
