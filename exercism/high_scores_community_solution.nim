import std/[algorithm]

proc latest*(scores: openArray[int]): int =
  scores[^1]

proc personalBest*(scores: openArray[int]): int =
  scores.max

proc personalTopThree*(scores: openArray[int]): seq[int] =
  scores.sorted.reversed[0 .. min(2, scores.high)]
