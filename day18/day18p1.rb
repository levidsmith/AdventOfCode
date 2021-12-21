#2021 Levi D. Smith
strFile = ARGV[0]

f = File.open(ARGV[0])

values = Array.new

f.readlines().each do | strLine |
    strInput = strLine.chomp


    if ((not strInput.start_with?("#")) && (strInput != ""))
        puts strInput
    end


end



f.close()
