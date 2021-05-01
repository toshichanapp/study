def rot(string, amount)
  pivot = ('a'.ord + amount % 26)
  string.tr('a-z', "#{pivot.chr}-za-#{(pivot + 1).chr}")
end

text = <<EOF
puvxlhwva
fubxha
tbxvtralb
jnerjnerun
xvzvgnpuvgb
lhxban
xnaxrvjb
xvmhxhgnzr
xbabubfuvav
lnggrxvgn
fnffbxhqntn
lhxbab
fuvehfuvgbfvgr
chermragbjb
bartnvfuvgnv
ranwvqbevaxh
mbar
jb
whaovfuvgr
ubfuvvabqn
xbabartnvjb
xnanrgrxhereron
bgbanfuvxh
xbabubfuvjb
ngbavfhehgfhzbevqn
jnerjnerun
nenfbvtbgbjb
abmbznanv
znrzhxvan
urawvjb
xvgnvfuvgrveh
EOF

text.split(/\R/).each do |line|
  p rot(line, 13)
end
