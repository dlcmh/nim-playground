import std/sugar

proc steps*(n: int): int =
  if n < 1: raise newException(ValueError, "n should be 1 or greater")

  result = 0
  var one = n
  while one != 1:
    dump (result, one)
    if one mod 2 == 0:
      one = one div 2
    else:
      one = one * 3 + 1
    result.inc

echo steps 16
