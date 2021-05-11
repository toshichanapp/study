# ruby solve1.rb 1:50 2:30 3:40 4:10

weights = { truck_1: 0, truck_2: 0, truck_3: 0 }
trucks = { truck_1: [], truck_2: [], truck_3: [] }
baggage = ARGV.map{ |str| str.split(':') }.to_h

baggage.each do |id, weight|
  min_key = weights.min_by{ |_key, value| value }.first
  weights[min_key] += weight.to_i
  trucks[min_key] << id
end

puts trucks
