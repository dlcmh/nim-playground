# import std/[algorithm, sequtils]
import std/sequtils

proc isTriangle(sides: array[3, int]): bool =
  [[0, 1, 2], [0, 2, 1], [1, 2, 0]].allIt(
    sides[it[0]] + sides[it[1]] >= sides[it[2]]
    )

proc isEquilateral*(sides: array[3, int]): bool =
  if sides.allIt it == 0: return
  deduplicate(sides).len == 1

proc isIsosceles*(sides: array[3, int]): bool =
  isTriangle(sides) and deduplicate(sides).len <= 2

proc isScalene*(sides: array[3, int]): bool =
  isTriangle(sides) and deduplicate(sides).len == 3

echo isScalene([7, 3, 2])

# let t = [7, 3, 2]

# for side in [[0, 1, 2], [0, 2, 1], [1, 2, 0]]:
#   echo t[side[0]], " + ", t[side[1]], " >= ", t[side[2]], "?"
#   echo t[side[0]] + t[side[1]] >= t[side[2]]

# var mt = [2, 3, 7]
# echo mt
# while mt.nextPermutation:
#   echo mt
