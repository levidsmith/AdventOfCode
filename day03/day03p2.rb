#2021 Levi D. Smith

$iResult = -1
USE_GREATER = 0
USE_FEWER = 1

def processValues(strInValues, iBit, iComparison)

	if (iBit > 0 and strInValues.length > 1)
		puts "processValues, bit: " + iBit.to_s

		iZeroCount = 0
		iOneCount = 0

		strInValues.each do  | strValue | 
			iIndex = strValue.length - iBit

			iBitValue = strValue[iIndex].to_i

			puts "value: " + strValue + " bit[" + iIndex.to_s + "]: " + iBitValue.to_s

			if (iBitValue == 0)
				iZeroCount += 1
			elsif (iBitValue == 1)
				iOneCount += 1
			end
		end

		strFilterValues = Array.new
		strInValues.each do  | strValue | 
			iIndex = strValue.length - iBit

			iBitValue = strValue[iIndex].to_i

			if (iComparison == USE_GREATER) 
				if (iZeroCount > iOneCount)
					if (iBitValue == 0)
						strFilterValues << strValue
					end

				elsif (iOneCount > iZeroCount)
					if (iBitValue == 1)
						strFilterValues << strValue
					end
			
				else
					if (iBitValue == 1)
						strFilterValues << strValue
					end

				end

			elsif(iComparison == USE_FEWER)
				if (iZeroCount < iOneCount)
					if (iBitValue == 0)
						strFilterValues << strValue
					end

				elsif (iOneCount < iZeroCount)
					if (iBitValue == 1)
						strFilterValues << strValue
					end
			
				else
					if (iBitValue == 0)
						strFilterValues << strValue
					end

				end

			end

		end


		puts "bit " + iBit.to_s + " 0s: " + iZeroCount.to_s + " 1s: " + iOneCount.to_s

		processValues(strFilterValues, iBit - 1, iComparison)
	
	else
		puts "Result: " + strInValues[0] + " decimal: " + getDecimalValue(strInValues[0]).to_s
		$iResult = getDecimalValue(strInValues[0])
	end

end

def getDecimalValue(strValue)
	i = 0
	iValue = 0

	while (i < strValue.length)
		if (strValue[i] == '1')
			iValue += 2 ** (strValue.length - i - 1)
		end
		i += 1
	end

	return iValue

end


strFile = ARGV[0]

f = File.open(strFile)

strValues = Array.new

f.readlines().each do  | strLine | 
	puts strLine
	strValues << strLine.chomp
end

f.close()

iBitCount = strValues[0].length

processValues(strValues, iBitCount, USE_GREATER)
iGenerator = $iResult

processValues(strValues, iBitCount, USE_FEWER)
iScrubber = $iResult

puts "Generator " + iGenerator.to_s
puts "Scrubber " + iScrubber.to_s

iLifeSupport = iGenerator * iScrubber
puts "Life support: " + iLifeSupport.to_s