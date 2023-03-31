import std/math

proc nChooseR(n: Positive, r: Positive): int =
  n.fac.floorDiv (r.fac * (n - r).fac)

echo nChooseR(5, 3) # 10
echo 8.nChooseR 3 # 56
echo 6.nChooseR 4 # 15
echo 6.nChooseR 3 # 20
echo 7.nChooseR 4 # 35
echo 7.nChooseR 3 # 35
echo 7.nChooseR 2 # 21
