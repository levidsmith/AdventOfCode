#2024 Levi D. Smith <developer@levidsmith.com>
def solve():

  list1 = []
  list2 = []

  f = open("../input01.txt", "r")

  for strLine in f:
    values = strLine.strip().split()
    list1.append(int(values[0]))
    list2.append(int(values[1]))

  f.close()

  if (len(list1) != len(list2)):
    print("Input error - lists not equal size")
    return

  list1.sort()
  list2.sort()

  i = 0
  iSize = len(list1)
  iSum = 0

  while (i < iSize):
    d = abs(list1[i] - list2[i])
    iSum += d
    i += 1 

  print(str(iSum))

solve()
