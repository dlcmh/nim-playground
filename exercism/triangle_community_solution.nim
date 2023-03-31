import algorithm

type Triangle = array[3, int]
type TriangleType = enum Illegal, Equilateral, Isosceles, Scalene

proc getType(triangle: Triangle): TriangleType =
  let
    sortedSides = triangle.sorted(system.cmp[int])
    a = sortedSides[0]
    b = sortedSides[1]
    c = sortedSides[2]
  if a <= 0 or (a + b <= c): Illegal
  elif a == c: Equilateral
  elif a == b or b == c: Isosceles
  else: Scalene

proc is_equilateral*(triangle: Triangle): bool =
  getType(triangle) == Equilateral

proc is_isosceles*(triangle: Triangle): bool =
  getType(triangle) in [Equilateral, Isosceles]

proc is_scalene*(triangle: Triangle): bool =
  getType(triangle) == Scalene

echo isScalene([7, 3, 2])
