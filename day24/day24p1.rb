#2021 Levi D. Smith

strFile = ARGV[0]

f = File.open(strFile)

f.readlines().each do  | strLine | 
    strInput = strLine.chomp
	puts strInput
end
