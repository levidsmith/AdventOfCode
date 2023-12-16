#2023 Levi D. Smith

iSum = 0
while (strLine = gets()) 
  strLine.chomp!()

  iFirst = nil
  iLast = nil

  iDigitStart = "0".ord
  iDigitEnd = "9".ord
  strLine.each_byte do |c|
    if (c >= iDigitStart and c <= iDigitEnd)
      if (iFirst.nil?)
        iFirst = c - iDigitStart
      end
      iLast = c - iDigitStart
    end
  end

  iValue = (iFirst * 10) + iLast
#  puts "value: #{iValue}"
  iSum += iValue
end

puts iSum


