#2021 Levi D. Smith

strFile = ARGV[0]

f = File.open(strFile)

lines = Array.new

f.readlines().each do  | strLine | 
    lines << strLine.chomp

end

f.close()

iAllFish = lines[0].split(",").collect { | str | str.to_i }

#SIMULATE_DAYS = 18
#SIMULATE_DAYS = 80
SIMULATE_DAYS = 256
TIMER_MAX = 8
TIMER_SPAWN_RATE = 6
iTimers = Array.new(TIMER_MAX + 1) { 0 }

iAllFish.each do | iValue |
    puts "value: #{iValue}"
    iTimers[iValue] += 1
end

for i in 0...(TIMER_MAX + 1)
    puts "Timer[#{i}]: #{iTimers[i]}"
end

for i in 0...SIMULATE_DAYS
    iSpawn = iTimers[0]

    for t in 0...(TIMER_MAX)
        iTimers[t] = iTimers[t + 1]
    end
    iTimers[TIMER_SPAWN_RATE] += iSpawn
    iTimers[TIMER_MAX] = iSpawn
end

iPopulation = 0
for t in 0...(TIMER_MAX + 1)
    iPopulation += iTimers[t]
end

puts "Result: #{iPopulation}"
