#2021 Levi D. Smith
strFile = ARGV[0]

f = File.open(ARGV[0])

f.readlines().each do | strLine |
    puts strLine.chomp

end

f.close()