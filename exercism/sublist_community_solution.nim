import sequtils

type Result* = enum
  Unequal, Equal, Sublist, SuperList

proc contains[T](x, y: openArray[T]): bool {.inline.} =
  anyIt(0 .. x.len-y.len, y == x[it ..< it+y.len])

proc sublist*(a, b: openArray[int]): Result =
  if a == b: result = Equal
  elif a in b: result = Sublist
  elif b in a: result = Superlist

when isMainModule:
  import unittest

  suite "Sublist":
    test "empty lists":
      check sublist([], []) == Equal

    test "empty list within non empty list":
      check sublist([], [1, 2, 3]) == Sublist

    test "non empty list contains empty list":
      check sublist([1, 2, 3], []) == Superlist

    test "list equals itself":
      check sublist([1, 2, 3], [1, 2, 3]) == Equal

    test "different lists":
      check sublist([1, 2, 3], [2, 3, 4]) == Unequal

    test "false start":
      check sublist([1, 2, 5], [0, 1, 2, 3, 1, 2, 5, 6]) == Sublist

    test "consecutive":
      check sublist([1, 1, 2], [0, 1, 1, 1, 2, 1, 2]) == Sublist

    test "sublist at start":
      check sublist([0, 1, 2], [0, 1, 2, 3, 4, 5]) == Sublist

    test "sublist in middle":
      check sublist([2, 3, 4], [0, 1, 2, 3, 4, 5]) == Sublist

    test "sublist at end":
      check sublist([3, 4, 5], [0, 1, 2, 3, 4, 5]) == Sublist

    test "at start of superlist":
      check sublist([0, 1, 2, 3, 4, 5], [0, 1, 2]) == Superlist

    test "in middle of superlist":
      check sublist([0, 1, 2, 3, 4, 5], [2, 3]) == Superlist

    test "at end of superlist":
      check sublist([0, 1, 2, 3, 4, 5], [3, 4, 5]) == Superlist

    test "first list missing element from second list":
      check sublist([1, 3], [1, 2, 3]) == Unequal

    test "second list missing element from first list":
      check sublist([1, 2, 3], [1, 3]) == Unequal

    test "first list missing additional digits from second list":
      check sublist([1, 2], [1, 22]) == Unequal

    test "order matters to a list":
      check sublist([1, 2, 3], [3, 2, 1]) == Unequal

    test "same digits but different numbers":
      check sublist([1, 0, 1], [10, 1]) == Unequal
