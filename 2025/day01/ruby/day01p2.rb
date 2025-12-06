#2025 Levi D. Smith <developer@levidsmith.com>
f = open("../input01.txt")

iCurrent = 50
iPassword = 0

MIN_VALUE = 0
MAX_VALUE = 99 
TARGET_VALUE = 0

while(strLine = f.gets)
#  puts strLine
  strLine.chomp!
  strDir = strLine[0]
  iValue = strLine[1..strLine.size].to_i

  case strDir
  when 'L'
    while (iValue > 0)
      iCurrent -= 1 
      if (iCurrent == TARGET_VALUE) 
        iPassword += 1
      elsif (iCurrent == MIN_VALUE - 1)
        iCurrent = MAX_VALUE 
      end
      iValue -= 1
    end
  when 'R'
    while (iValue > 0)
      iCurrent += 1 
      if (iCurrent == MAX_VALUE + 1) 
        iCurrent = MIN_VALUE 
      end
      if (iCurrent == TARGET_VALUE) 
        iPassword += 1
      end
      iValue -= 1
    end
  end



#  puts "password #{iPassword}"
#  puts "current #{iCurrent}"

end
f.close

puts iPassword
