import std/[strutils]

proc nextPermutation(digits: int, chosen: var seq[int]) =
  if digits == 0:
    echo chosen.join
  else:
    for i in countup(0, 9):
      chosen.add i
      nextPermutation(digits - 1, chosen)
      discard chosen.pop

var chosen: seq[int]
nextPermutation(5, chosen)
