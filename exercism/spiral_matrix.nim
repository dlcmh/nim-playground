type Direction = enum
  Right, Down, Left, Up

const Move = [Right: (0, 1), Down: (1, 0), Left: (0, -1), Up: (-1, 0)]

proc spiral*(n: static int): array[n, array[n, int]] =
  var coord = (0, 0)
  var d = Direction.low
  var move = Move[d]
  for i in 0 .. (n * n) - 1:
    let (x, y) = coord
    result[x][y] = i + 1
    let nextCoord = ([n - 1, [(x + move[0]).abs, 0].max].min,
                     [n - 1, [(y + move[1]).abs, 0].max].min)
    if result[nextCoord[0]][nextCoord[1]] != 0:
      if d == Direction.high:
        d = Direction.low
      else:
        d.inc
    move = Move[d]
    coord = (coord[0] + move[0], coord[1] + move[1])

when isMainModule:
  import unittest

  suite "Spiral Matrix":
    test "empty spiral":
      check spiral(0) == []

    test "trivial spiral":
      check spiral(1) == [[1]]

    test "spiral of size 2":
      check spiral(2) == [[1, 2],
                          [4, 3]]

    test "spiral of size 3":
      check spiral(3) == [[1, 2, 3],
                          [8, 9, 4],
                          [7, 6, 5]]

    test "spiral of size 4":
      check spiral(4) == [[1, 2, 3, 4],
                          [12, 13, 14, 5],
                          [11, 16, 15, 6],
                          [10, 9, 8, 7]]

    test "spiral of size 5":
      check spiral(5) == [[1, 2, 3, 4, 5],
                          [16, 17, 18, 19, 6],
                          [15, 24, 25, 20, 7],
                          [14, 23, 22, 21, 8],
                          [13, 12, 11, 10, 9]]
