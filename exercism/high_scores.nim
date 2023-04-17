import std/[algorithm]

type Scores = openArray[int]

proc latest*(scores: Scores): int =
  scores[^1]

proc personalTopThree*(scores: Scores): seq[int] =
  scores.sorted(order = Descending)[0 .. min(2, scores.len - 1)]

proc personalBest*(scores: Scores): int =
  personalTopThree(scores)[0]

when isMainModule:
  import std/[unittest]

  suite "Latest score":
    test "latest score":
      check latest(@[100, 0, 90, 30]) == 30

  suite "Personal best":
    test "personal best":
      check personalBest(@[40, 100, 70]) == 100

  suite "Top 3 scores":
    test "personal top three from a list of scores":
      check personalTopThree(@[10, 30, 90, 30, 100, 20,
                               10, 0, 30, 40, 40, 70, 70]) == @[100, 90, 70]

    test "personal top highest to lowest":
      check personalTopThree(@[20, 10, 30]) == @[30, 20, 10]

    test "personal top when there is a tie":
      check personalTopThree(@[40, 20, 40, 30]) == @[40, 40, 30]

    test "personal top when there are less than 3":
      check personalTopThree(@[30, 70]) == @[70, 30]

    test "personal top when there is only one":
      check personalTopThree(@[40]) == @[40]
