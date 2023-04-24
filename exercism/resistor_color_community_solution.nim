import std/[sequtils]

type
  ResistorColor* = enum
    Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White

proc colorCode*(color: ResistorColor): int =
  color.ord

proc colors*: seq[ResistorColor] =
  ResistorColor.toSeq

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
