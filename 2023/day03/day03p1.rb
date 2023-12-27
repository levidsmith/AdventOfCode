#2023 Levi D. Smith

def main() 
    iSum = 0

	strLines = []
    while (strLine = gets()) 
        strLine.chomp!()
		strLines.push(strLine)
	end


	values = []
	
	i = 0
    while (i < strLines.length) 
		j = 0
		strNumber = ""
#		puts "line: " + strLines[i]
		
		strLines[i].chars.each { |c|
			isNumberComplete = false
#			print c
			if (getIsANumber(c)) 
				strNumber += c
			end
			
			#check after last character on line has been reached
			if ( (j == strLines[i].chars.length - 1) or
			     (not getIsANumber(strLines[i].chars[j + 1]) ) )
				if (strNumber != "")
					isNumberComplete = true
				end
			end
			
			if (isNumberComplete) 
#				puts "Found: #{strNumber}"
				if getIsSymbolAdjacent(strLines, i, j - strNumber.length + 1, strNumber.length)
#					puts "adding"
					values.push(strNumber.to_i)
				end
				strNumber = ""
			end
			
			j += 1
		}

		i += 1
    end

#	puts values
	
	iSum = values.inject(0, :+)

    puts iSum
end

def getIsANumber(c)
	if (c.ord >= '0'.ord and c.ord <= '9'.ord) 
		return true
	else
		return false
	end

end


def getIsSymbolAdjacent(strLines, iRow, iCol, iLength)
	isSymbolAdjacent = false

#	puts "row: #{iRow} col: #{iCol} col + len: #{iCol + iLength}"
	
	#check preceeding character for special character
	if (iCol > 0)
#		puts "before: #{strLines[iRow].chars[iCol - 1]}"
		if (strLines[iRow].chars[iCol - 1] != '.') 
			isSymbolAdjacent = true
		end
	end
	
	#check following character for special character
	if (iCol + iLength < strLines[iRow].length)
#		puts "after: #{strLines[iRow].chars[iCol + iLength]}"
		if (strLines[iRow].chars[iCol + iLength] != '.')
			isSymbolAdjacent = true
		end
	end
	
	#check previous row for special characters
	if (iRow > 0)
		iColStart = iCol - 1
		if (iColStart < 0) 
			iColStart = 0
		end

#		puts "above: #{strLines[iRow - 1][iColStart .. iCol + iLength]}"
		strLines[iRow - 1][iColStart .. iCol + iLength].chars.each { | c |
			if (c != '.' and not getIsANumber(c))
				isSymbolAdjacent = true
			end
		}
	end
	
	#check next row for special characters
	if (iRow < strLines.length - 1)
		iColStart = iCol - 1
		if (iColStart < 0) 
			iColStart = 0
		end
		
#		puts "below: #{strLines[iRow + 1][iColStart .. iCol + iLength]}"
		strLines[iRow + 1][iColStart .. iCol + iLength].chars.each { | c |
			if (c != '.' and not getIsANumber(c))
				isSymbolAdjacent = true
			end
		}
	
	end
	
	return isSymbolAdjacent
end

main()