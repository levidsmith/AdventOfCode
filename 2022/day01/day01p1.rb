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

puts "Max bag: #{bags.last}"