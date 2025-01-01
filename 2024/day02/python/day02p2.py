#2024 Levi D. Smith <developer@levidsmith.com>
def solve():
  f = open("../input01.txt", "r")

  iSum = 0
  for strLine in f:
    values = strLine.strip().split()
#    print(values)

    if (checkSafe(values)):
#      print("SAFE")
      iSum +=1
    else:
      for i in range (0, len(values)):
        values1 = values.copy()
        del values1[i]
#        print("Check - remove index %d" % i) 
#        print(values1)
        if (checkSafe(values1)):
#          print("SAFE")
          iSum += 1
          break
  f.close()

  print(str(iSum))


def checkSafe(values):
  values = list(map(int, values))

  iPrev = None 
  iIncr = None
  
  i = 0
  for v in values:
    if not (iPrev is None):
      iDiff = v - iPrev
      if abs(iDiff) < 1 or abs(iDiff) > 3:
        return False 

      if (iIncr is None):
        iIncr = iDiff
      else:
        if not ( (iIncr < 0) == (iDiff < 0) ):
          return False 

    iPrev = v
    i += 1

  return True 

solve()



