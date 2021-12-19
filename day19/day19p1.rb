#2021 Levi D. Smith

strFile = ARGV[0]


f = File.open(ARGV[0])


f.readlines().each do | strLine |
    strInput = strLine.chomp

    if (not strInput.start_with?("#"))
        puts strInput
    end


end



f.close()
