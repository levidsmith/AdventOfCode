#2025 Levi D. Smith
f = open("../input01.txt")
while( strLine = f.gets )
  i = 0
  iValue = 0
  strLine.chars.each { 
    | c |
    case c[0]
    when '('
      iValue += 1 
    when ')'
      iValue -= 1
    end

    if (iValue == -1)
      puts(i + 1)
      break
    end
    i += 1
  }
end
f.close
