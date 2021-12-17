#2021 Levi D. Smith
strFile = ARGV[0]

f = File.open(ARGV[0])

f.readlines().each do | strLine |
    puts strLine.chomp

    m = strLine.match(/target area: x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)/)

    puts "x1: #{m[1]} x2: #{m[2]} y1: #{m[3]} y4: #{m[4]}"

end

f.close()