import std/[algorithm, math]

proc convert*(digits: openArray[int], fromBase: int, toBase: int): seq[int] =
  if fromBase <= 1: raise new ValueError
  if toBase <= 1: raise new ValueError

  var ints: seq[int]
  for i, v in digits.reversed:
    if v < 0: raise new ValueError
    if v >= fromBase: raise new ValueError
    ints.add v * (fromBase ^ i)
  var t = ints.sum
  if t == 0: return @[0]
  while t > 0:
    result.add t mod toBase
    t = t div toBase
  result.reverse

echo convert(@[1], 2, 10)
echo convert(@[1, 0, 1], 2, 10)
echo convert(@[5], 10, 2)
echo convert(@[1, 1, 2, 0], 3, 16)
echo convert([], 2, 10)
