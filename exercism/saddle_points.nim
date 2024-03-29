import std/[sequtils, sugar]

proc saddlePoints*(matrix: seq[seq[int]]): seq[tuple[r, c: int]] =
  if matrix.len == 0: return
  let rowHighestCoords = collect:
    for ri, row in matrix:
      let highest = row.max
      for ci, v in row:
        if v == highest:
          (ri.succ, ci.succ)
  for ci in 0 .. matrix[0].high:
    let lowest = matrix.mapIt(it[ci]).min
    for ri, row in matrix:
      if row[ci] == lowest and
        (ri.succ, ci.succ) in rowHighestCoords:
        result.add (ri.succ, ci.succ)
  # let colLowestCoords = collect:
  #   for ci in 0 .. matrix[0].high:
  #     let lowest = matrix.mapIt(it[ci]).min
  #     for ri, row in matrix:
  #       if row[ci] == lowest:
  #         (ri.succ, ci.succ)
  # for coord in rowHighestCoords:
  #   if coord in colLowestCoords:
  #     result.add coord

when isMainModule:
  import unittest, algorithm

  suite "Saddle Points":
    test "can identify single saddle point":
      const input = @[
        @[9, 8, 7],
        @[5, 3, 2],
        @[6, 6, 7]
      ]
      const expected = @[(2, 1)]
      check saddlePoints(input) == expected

    test "can identify that empty matrix has no saddle points":
      const input = newSeq[seq[int]]()
      check saddlePoints(input).len == 0

    test "can identify lack of saddle points when there are none":
      const input = @[
        @[1, 2, 3],
        @[3, 1, 2],
        @[2, 3, 1]
      ]
      check saddlePoints(input).len == 0

    test "can identify multiple saddle points in a column":
      const input = @[
        @[4, 5, 4],
        @[3, 5, 5],
        @[1, 5, 4]
      ]
      const expected = @[(1, 2), (2, 2), (3, 2)]
      check saddlePoints(input).sorted == expected

    test "can identify multiple saddle points in a row":
      const input = @[
        @[6, 7, 8],
        @[5, 5, 5],
        @[7, 5, 6]
      ]
      const expected = @[(2, 1), (2, 2), (2, 3)]
      check saddlePoints(input).sorted == expected

    test "can identify saddle point in bottom right corner":
      const input = @[
        @[8, 7, 9],
        @[6, 7, 6],
        @[3, 2, 5]
      ]
      const expected = @[(3, 3)]
      check saddlePoints(input) == expected

    test "can identify saddle points in a non square matrix":
      const input = @[
        @[3, 1, 3],
        @[3, 2, 4]
      ]
      const expected = @[(1, 1), (1, 3)]
      check saddlePoints(input).sorted == expected

    test "can identify that saddle points in a single column matrix are those with the minimum value":
      const input = @[
        @[2],
        @[1],
        @[4],
        @[1]
      ]
      const expected = @[(2, 1), (4, 1)]
      check saddlePoints(input).sorted == expected

    test "can identify that saddle points in a single row matrix are those with the maximum value":
      const input = @[
        @[2, 5, 3, 5]
      ]
      const expected = @[(1, 2), (1, 4)]
      check saddlePoints(input).sorted == expected
