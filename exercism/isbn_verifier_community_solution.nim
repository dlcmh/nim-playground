import strutils, re

proc isValid*(input: string): bool =
  let input = input.replace("-", "")
  if not input.match(re"^\d{9}[X\d]$"): return false
  var sum = 0
  for i in 0..9:
    var x = input[i].ord - ord('0')
    if x > 9: x = 10
    sum += (10 - i) * x
  sum mod 11 == 0
