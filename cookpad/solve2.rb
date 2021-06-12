# ruby solve2.rb griffin vampire dragon troll medusa
require 'set'
require 'net/http'
require 'uri'
require 'json'

# 対戦履歴を作る
# 自分より強い奴らをメモ
@winners = Hash.new{ |hash, key| hash[key] = Set.new }
# 自分より弱い奴らをメモ
@losers = Hash.new{ |hash, key| hash[key] = Set.new }
@req_count = 0

def battle(monster1, monster2)
  url = 'https://ob6la3c120.execute-api.ap-northeast-1.amazonaws.com/Prod/battle/'
  res = JSON.parse(Net::HTTP.get(URI.parse(File.join(url,"#{monster1}+#{monster2}"))))
  #ex => {"winner":"dragon","loser":"griffin"}

  @losers[res['winner']] << res['loser']
  @winners[res['loser']] << res['winner']
  @req_count +=1
end

all_combination = ARGV.sort.combination(2)
# winnerはloserのlosersよりも強い
# loserのlosersはwinnerより弱い
all_combination.each do |m1, m2|
  case
  when @losers[m1].any? { |m| @losers[m].include?(m2) } # 相手が勝ったことのあるやつより弱いか調べる
    @losers[m1] << m2
    @winners[m2] << m1
  when @winners[m1].any? { |m| @winners[m].include?(m2) } # 相手が負けたやつよりも強いやつか調べる
    @winners[m1] << m2
    @losers[m2] << m1
  else
    battle(m1, m2)
  end
end

p @losers.sort_by{ |key, value| value.count }
p @req_count

# 試行錯誤
=begin
["dragon", "griffin"], ["dragon", "medusa"], ["dragon", "troll"], ["dragon", "vampire"],
["griffin", "medusa"], ["griffin", "troll"], ["griffin", "vampire"],
["medusa", "troll"], ["medusa", "vampire"],
["troll", "vampire"]
=end

=begin
[["griffin", #<Set: {"vampire"}>],
 ["medusa", #<Set: {"griffin", "vampire"}>],
 ["dragon", #<Set: {"griffin", "medusa", "vampire"}>],
 ["troll", #<Set: {"dragon", "griffin", "medusa", "vampire"}>]]
=end
