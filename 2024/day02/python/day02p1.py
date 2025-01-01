#2024 Levi D. Smith <developer@levidsmith.com>
def solve():
  f = open("../input01.txt", "r")

  iSum = 0
  for strLine in f:
    values = strLine.strip().split()
    if checkSafe(values):
      iSum += 1

  f.close()

  print(str(iSum))


def checkSafe(values):
#  print(values)
  values = list(map(int, values))
  isSafe = True

  iPrev = None 
  iIncr = None
  for v in values:
#    print("%d" % v)  
    if not (iPrev is None):
      iDiff = v - iPrev
#      print("prev: %d, diff: %d" % (iPrev, iDiff))
      if abs(iDiff) < 1 or abs(iDiff) > 3:
#        print("UNSAFE min/max")
        return False

      if (iIncr is None):
        iIncr = iDiff
#        print("Set Incr to %d", iIncr)
      else:
#        print("(%d < 0) == (%d < 0)" % (iIncr, iDiff))
       
        if not ( (iIncr < 0) == (iDiff < 0) ):
#          print("UNSAFE incr/decr")
          return False
    iPrev = v

#  print("SAFE")
  return isSafe 

solve()



