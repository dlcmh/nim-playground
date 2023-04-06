## Generate sequence of digits from a number.
proc digits(n: Natural, reversed = true): seq[int] =
  var num = n
  while num > 0:
    result.add num mod 10
    num = num div 10

  if not reversed:
    var reversed = @[result[result.high]]
    for v in countdown(result.high - 1, result.low):
      reversed.add result[v]
    return reversed


when isMainModule:
  doAssert digits(100) == @[0, 0, 1]
  echo digits(100)
  doAssert digits(100, false) == @[1, 0, 0]
  echo digits(100, false)
