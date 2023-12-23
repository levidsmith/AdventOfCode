#2023 Levi D. Smith
def main() 
    iSum = 0

    while (strLine = gets()) 
		limits = {
			"red" => 0,
			"green" => 0,
			"blue" => 0
		}
        strLine.chomp!()
        strLine = strLine + ';'
        
        i = 0
        strGameText = "Game "
        iGameStart = strLine.index(strGameText) + strGameText.length
        iGameEnd =  strLine.index(':')
        iGame = strLine[iGameStart ... iGameEnd].to_i

        i = iGameEnd
        iStart = i + 1
        isValid = true
        while (i < strLine.length)

            
            if (strLine[i] == ',' or strLine[i] == ';')
                strCubeCount = strLine[iStart...i].strip()
                iStart = i + 1

                arrCubeCount = strCubeCount.split(' ')
                iNum = arrCubeCount[0].to_i
                strColor = arrCubeCount[1]
				
#				puts  "#{strColor}: #{iNum}"

                if (iNum > limits[strColor])
                    limits[strColor] = iNum
                end
            end
          
            i += 1
        end
		
#		puts "Game #{iGame}: red #{limits['red']}, green #{limits['green']}, blue #{limits['blue']}"
		iPower = limits['red'] * limits['green'] * limits['blue']
		puts "Game #{iGame}: power #{iPower}"
		
		iSum += iPower

    end

    puts iSum
end

main()