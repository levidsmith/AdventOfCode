#2023 Levi D. Smith
import sys

def main():
    iSum = 0
    digitNames = {
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }

    for strLine in sys.stdin:
        strLine = strLine.rstrip()

        iDigits = []
        iDigitStart = ord("0")
        iDigitEnd = ord("9")

        for i in range(len(strLine)):
            if (ord(strLine[i]) >= iDigitStart and ord(strLine[i]) <= iDigitEnd):
                iDigits.append(ord(strLine[i]) - iDigitStart)

            for key in digitNames:
                if (key == strLine[i:i + len(key)]):
                    iDigits.append(digitNames[key])

#        print(strLine + str(iDigits))
        iValue = (iDigits[0] * 10) + iDigits[len(iDigits) - 1]
        iSum += iValue

    print(iSum)

main()
