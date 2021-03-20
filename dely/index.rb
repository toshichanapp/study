# https://www.dely.jp/lp/recruit/engineer_challenge_202007.html

LIST = 'abcdefghijklmnopqrstuvwxyz'

def decode(str)
  str.scan(/([a-z])([0-9]+)/).map do |alpha, num|
    diff_index = num.to_i.even? ? num.to_i : -num.to_i
    LIST[(LIST.index(alpha) + diff_index) % LIST.length]
  end.join
end

str = 'k46927595597b23999455421q67482438962k54959663593t66323632674o97789468516j64445937397y88486785969s72835486740c83666964247g32493592926i57254538568g24323636572x76885739897v32752784694f49994245441b25742799753'
p decode(str)
