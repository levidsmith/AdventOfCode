#2025 Levi D. Smith
f = open("../input01.txt")
while( strLine = f.gets )
  iValue = 0
  strLine.chars.each { 
    | c |
    case c[0]
    when '('
      iValue += 1 
    when ')'
      iValue -= 1
    end
  }
  puts iValue
end
f.close
