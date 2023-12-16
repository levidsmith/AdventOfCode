#2023 Levi D. Smith
def main() 
    iSum = 0

    limits = {
        "red" => 12,
        "green" => 13,
        "blue" => 14
    }

    while (strLine = gets()) 
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

                if (iNum > limits[strColor])
                    isValid = false
                end
            end
          
            i += 1
        end

        if (isValid)
            iSum += iGame

        end
    end

    puts iSum
end

main()