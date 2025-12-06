#2025 Levi D. Smith <developer@levidsmith.com>
f = open("../input01.txt")

iTotal = 0
while (strLine = f.gets)
  arrLengths = strLine.split('x').map! { 
    | iValue |
    iValue.to_i
  }
#  puts "Lengths"
#  puts arrLengths

  l = arrLengths[0]
  w = arrLengths[1]
  h = arrLengths[2]

  arrSizes = [ l * w, w * h, h * l]

#  puts "Sizes"
#  puts arrSizes
  arrSizes.sort!

  iRequired = (2 * l * w) + (2 * w * h) + (2 * h * l) + arrSizes[0]

#  puts iRequired 
  iTotal += iRequired
end
f.close

puts iTotal

