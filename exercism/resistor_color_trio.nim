import std/[math, strutils]

type
  ResistorColor* = enum
    Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White

proc label*(r: array[3, ResistorColor]): tuple[value: int, unit: string] =
  var comps = formatEng(
    float((r[0].ord * 10 + r[1].ord) * 10 ^ r[2].ord), siPrefix = true,
        useUnitSpace = true).split
  case comps[1]
    of "k": comps[1] = "kiloohms"
    of "M": comps[1] = "megaohms"
    of "G": comps[1] = "gigaohms"
    else: comps[1] = "ohms"
  (comps[0].parseInt, comps[1])

when isMainModule:
  import unittest

  suite "Resistor Color Trio":
    test "orange and orange and black":
      check label([Orange, Orange, Black]) == (33, "ohms")

    test "blue and grey and brown":
      check label([Blue, Grey, Brown]) == (680, "ohms")

    test "red and black and red":
      check label([Red, Black, Red]) == (2, "kiloohms")

    test "green and brown and orange":
      check label([Green, Brown, Orange]) == (51, "kiloohms")

    test "yellow and violet and yellow":
      check label([Yellow, Violet, Yellow]) == (470, "kiloohms")

    test "blue and violet and blue":
      check label([Blue, Violet, Blue]) == (67, "megaohms")

    test "minimum possible value":
      check label([Black, Black, Black]) == (0, "ohms")

    test "maximum possible value":
      check label([White, White, White]) == (99, "gigaohms")

    test "first two colors make an invalid octal number":
      check label([Black, Grey, Black]) == (8, "ohms")
