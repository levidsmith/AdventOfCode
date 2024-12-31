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

  i = 0
  iSize = len(list1)
  iSum = 0

  while (i < iSize):
    c = list2.count(list1[i])
    v = list1[i] * c
#    print("%d c: %d v: %d" % (list1[i], c, v))
    iSum += v
    i += 1 

  print(str(iSum))

solve()
