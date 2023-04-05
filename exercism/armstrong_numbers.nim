import std/[math, strutils]

proc isArmstrongNumber*(n: int): bool =
  var sum = 0
  for i in $n:
    sum += parseInt($i) ^ len($n)
  n == sum
