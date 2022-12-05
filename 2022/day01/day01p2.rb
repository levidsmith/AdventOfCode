#2022 Levi D. Smith (levidsmith.com)

bags = Array.new
f = File.new(ARGV[0])

iBag = 0
f.each do | line |
    puts "linei: #{line}"
    iBag += line.to_i
    
    if (line.strip == "")
        puts "Bag total: #{iBag}"
        bags << iBag
        puts "New bag"
        iBag = 0
    end
end

puts "Last bag"
bags << iBag

f.close()

bags.sort!
bags.each do | i |
    puts i
end


iCount = 3
puts "last #{iCount} bags"
i = 0
iTotal = 0
while (i < iCount)
    puts "last bag: #{bags[bags.count - 1 - i]}"
    iTotal += bags[bags.count - 1 - i]
    i += 1
end

puts "Total #{iTotal}"