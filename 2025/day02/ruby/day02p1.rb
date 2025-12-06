#2025 Levi D. Smith <developer@levidsmith.com>
f = open("../input01.txt")
strLine = f.gets
strLine.chomp!
f.close
#puts strLine

arrRanges = strLine.split(',')

iTotal = 0
arrRanges.each {
  | strRange |
#  puts "range: #{strRange}"

  arrRangeValues = strRange.split('-')

  iRangeStart = arrRangeValues[0].to_i
  iRangeEnd = arrRangeValues[1].to_i

#  puts "start: #{iRangeStart} end: #{iRangeEnd}"

  (iRangeStart..iRangeEnd).each {
    | iValue |
#    puts "value: #{iValue}"

    iDigits = 0
    while (iValue / (10 ** iDigits) > 0)
      iDigits += 1
    end  

#    puts "digits: #{iDigits}"

    if (iDigits % 2 == 0) 
      if (iValue / (10 ** (iDigits / 2)) == iValue % (10 ** (iDigits / 2)))
#        puts "found: #{iValue}"
        iTotal += iValue
      end
    end

  }
}

puts iTotal
