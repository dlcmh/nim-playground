type
  ResistorColor* = enum
    Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White

proc colorCode*(color: ResistorColor): int =
  color.ord

proc colors*: array[0..ResistorColor.high.ord, ResistorColor] =
  for i in ResistorColor:
    result[i.ord] = i

when isMainModule:
  import unittest

  suite "Resistor Color":
    test "black":
      check colorCode(Black) == 0

    test "white":
      check colorCode(White) == 9

    test "orange":
      check colorCode(Orange) == 3

    test "all resistor colors":
      check colors() == [Black, Brown, Red, Orange, Yellow,
                        Green, Blue, Violet, Grey, White]
