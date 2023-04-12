import std/[math]

proc score*(x, y: float): int =
  let r = (x.abs.pow(2) + y.abs.pow(2)).sqrt
  if r <= 1:
    result = 10
  elif r <= 5:
    result = 5
  elif r <= 10:
    result = 1

when isMainModule:
  # doAssert score(0.0, 10.0) == 1
  # echo score(0.0, 10.0)

  # doAssert score(-9.0, 9.0) == 0
  echo score(-9.0, 9.0)
