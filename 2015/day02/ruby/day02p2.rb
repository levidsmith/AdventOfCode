#2025 Levi D. Smith <developer@levidsmith.com>
f = open("../input01.txt")

iTotal = 0
while (strLine = f.gets)
  arrLengths = strLine.split('x').map! { 
    | iValue |
    iValue.to_i
  }

  arrLengths.sort!
  iRequired = (arrLengths[0] * 2) + 
              (arrLengths[1] * 2) + 
              (arrLengths[0] * arrLengths[1] * arrLengths[2])

#  puts iRequired

  iTotal += iRequired
end
f.close

puts iTotal

