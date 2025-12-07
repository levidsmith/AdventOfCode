#2025 Levi D. Smith <developer@levidsmith.com>

def getInput(strFile)
  f = open(strFile)
  strLine = f.gets
  strLine.chomp!
  f.close
  return strLine
end

def processData(strInput)
  arrRanges = strInput.split(',')

  iTotal = 0
  arrRanges.each {
    | strRange |

    arrRangeValues = strRange.split('-')

    iRangeStart = arrRangeValues[0].to_i
    iRangeEnd = arrRangeValues[1].to_i

    (iRangeStart..iRangeEnd).each {
      | iValue |
      (1..getDigits(iValue) / 2).each {
        | iCount |
        if (isRepeatPossible(iValue, iCount))
          if (checkValue(iValue, iCount)) 
            iTotal += iValue
            break
          end
        end
      }
    }
  }
  puts iTotal
end

def getNumberAt(iValue, iPosition, iCount) 
  iDigits = getDigits(iValue)
  iValue = iValue / (10 ** (iDigits - iCount - iPosition))
  iValue = iValue % (10 ** iCount) 
  return iValue
end

def getDigits(iValue)
    iDigits = 0
    while (iValue / (10 ** iDigits) > 0)
      iDigits += 1
    end  

    return iDigits
end

def isRepeatPossible(iValue, iCount)
  iDigits = getDigits(iValue)

  if (iCount > iDigits / 2)
    return false
  elsif (iDigits % iCount != 0)
    return false
  else
    return true
  end
end

def checkValue(iValue, iCount)
  iOrig = getNumberAt(iValue, 0, iCount)  
  iDigits = getDigits(iValue)
  (1...(iDigits / iCount)).each {
    | i |
    if (iOrig != getNumberAt(iValue, i * iCount, iCount))
      return false
    end 
  }
  return true
end

strInput = getInput("../input01.txt")
processData(strInput)
