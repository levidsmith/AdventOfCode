#2023 Levi D. Smith
def main() 
    iSum = 0
    digitNames = {
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9
    }

    while (strLine = gets()) 
        iDigits = []
        strLine.chomp!()
#        puts strLine

        iDigitStart = "0".ord
        iDigitEnd = "9".ord

        i = 0
        for i in 0..strLine.size - 1 do
            digitNames.each do | key, value |

                if (strLine[i, key.size] == key)
#                    print "*#{value}"
                    iDigits.push(value)
                end
            end

            if (strLine[i].ord >= iDigitStart and strLine[i].ord <= iDigitEnd) 
#                print "*#{strLine[i]}"
                iDigits.push(strLine[i].ord - iDigitStart)
            end

        end
#        puts "digits: #{iDigits}"
#        puts "value: #{iDigits[0]}#{iDigits[iDigits.length - 1]}"
        iValue = (iDigits[0] * 10) + iDigits[iDigits.length - 1]
        iSum += iValue
    end

    puts iSum
end

main()