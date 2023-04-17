import std/[algorithm]

type Scores = openArray[int]

proc latest*(scores: Scores): int =
  discard

proc personalBest*(scores: Scores): int =
  discard

proc personalTopThree*(scores: Scores): seq[int] =
  scores.sorted(order = Descending)[0 .. 2]

when isMainModule:
  import std/[unittest]

  suite "Top 3 scores":
    test "personal top three from a list of scores":
      check personalTopThree(
        @[10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]) == @[100, 90, 70]
