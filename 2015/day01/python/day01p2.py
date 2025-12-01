#2025 Levi D. Smith
def main():
  with open("../input01.txt", "r") as f:
    strLine = f.readline()
    while (strLine != ''):
#      print(strLine)
      iValue = 0
      i = 0
      for char in strLine:
        if char == '(':
          iValue += 1
        elif char == ')':
          iValue -= 1

        if (iValue == -1):
          print(i + 1)
          break
        i += 1
      strLine = f.readline()


if __name__ == "__main__":
  main()
