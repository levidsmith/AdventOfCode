#2025 Levi D. Smith <developer@levidsmith.com>
f = open("../input01.txt")

iCurrent = 50
iPassword = 0
while(strLine = f.gets)
#  puts strLine
  strDir = strLine[0]
  iValue = strLine[1..strLine.size].to_i

  case strDir
  when 'L'
    iCurrent -= iValue
  when 'R'
    iCurrent += iValue
  end

  iCurrent = iCurrent % 100
#  puts "current: #{iCurrent}"
  if (iCurrent == 0)
    iPassword += 1
  end

end
f.close

puts iPassword
