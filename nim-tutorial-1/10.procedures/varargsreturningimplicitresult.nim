proc sumTillNegative(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result += i

echo sumTillNegative() # echoes 0
echo sumTillNegative(3, 4, 5) # echoes 12
echo sumTillNegative(3, 4, -1, 6) # echoes 7
