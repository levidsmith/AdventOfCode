#2021 Levi D. Smith

strFile = ARGV[0]

f = File.open(strFile)

iBitCount = -1

iZeroCount = Array.new
iOneCount = Array.new

isFirstLine = true

f.readlines().each do  | strLine | 
	puts strLine
	i = 0
	
	if (isFirstLine)
		iBitCount = strLine.chomp.length
		isFirstLine = false

		i = 0
		while (i < iBitCount)
			iZeroCount[i] = 0
			iOneCount[i] = 0
			i += 1;
		end

	end
	
	while (i < strLine.length)
		if (strLine[i] == '0') 
			iZeroCount[i] += 1
		
		elsif (strLine[i] == '1')
			iOneCount[i] += 1
		end
		i += 1;
	end
end

f.close()


i = 0
iGamma = 0
iEpsilon = 0
while (i < iBitCount)
		puts "[" + i.to_s + "] 0s: " + iZeroCount[i].to_s + " 1s: " + iOneCount[i].to_s
		
		if (iOneCount[i] > iZeroCount[i])
			iGamma += 2 ** (iBitCount - 1 - i)
		else
			iEpsilon += 2 ** (iBitCount - 1 - i)
		end
		i += 1;
end

puts "Gamma " + iGamma.to_s
puts "Epsilon " + iEpsilon.to_s

iPowerConsumption = iGamma * iEpsilon
puts "Power consumption: " + iPowerConsumption.to_s