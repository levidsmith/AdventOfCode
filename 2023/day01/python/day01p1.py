#2023 Levi D. Smith
import sys

iSum = 0

for strLine in sys.stdin:
    strLine = strLine.rstrip()

    iFirst = None
    iLast = None

    iDigitStart = ord("0")
    iDigitEnd = ord("9")

    for c in strLine:
        if (ord(c) >= iDigitStart and ord(c) <= iDigitEnd):
            if (iFirst == None):
                iFirst = ord(c) - iDigitStart

            iLast = ord(c) - iDigitStart

    iValue = (iFirst * 10) + iLast
    iSum += iValue
print(iSum)
