import std/[strutils]

proc roman*(n: int): string =
  proc units(n: int): string =
    let n = n mod 10
    if n <= 3: result.add repeat("I", n)
    elif n == 4: result.add "IV"
    elif n == 5: result.add "V"
    elif n <= 8: result.add "V" & repeat("I", n - 5)
    elif n == 9: result.add "IX"
  proc tens(n: int): string =
    let n = (n mod 100) div 10
    if n <= 3: result.add repeat("X", n)
    elif n == 4: result.add "XL"
    elif n <= 8: result.add "L" & repeat("X", n - 5)
    elif n == 9: result.add "XC"
  proc hundreds(n: int): string =
    let n = (n mod 1000) div 100
    if n <= 3: result.add repeat("C", n)
    elif n == 4: result.add "CD"
    elif n <= 8: result.add "D" & repeat("C", n - 5)
    elif n == 9: result.add "CM"
  proc thousands(n: int): string =
    let n = n div 1000
    result.add repeat("M", n)
  if n < 10: result.add units(n)
  elif n < 100:
    result.add tens(n)
    result.add units(n)
  elif n < 1000:
    result.add hundreds(n)
    result.add tens(n)
    result.add units(n)
  elif n < 4000:
    result.add thousands(n)
    result.add hundreds(n)
    result.add tens(n)
    result.add units(n)


when isMainModule:
  import unittest

  suite "Roman Numerals":
    test "1 is I":
      check roman(1) == "I"

    test "2 is II":
      check roman(2) == "II"

    test "3 is III":
      check roman(3) == "III"

    test "4 is IV":
      check roman(4) == "IV"

    test "5 is V":
      check roman(5) == "V"

    test "6 is VI":
      check roman(6) == "VI"

    test "9 is IX":
      check roman(9) == "IX"

    test "27 is XXVII":
      check roman(27) == "XXVII"

    test "48 is XLVIII":
      check roman(48) == "XLVIII"

    test "49 is XLIX":
      check roman(49) == "XLIX"

    test "59 is LIX":
      check roman(59) == "LIX"

    test "93 is XCIII":
      check roman(93) == "XCIII"

    test "141 is CXLI":
      check roman(141) == "CXLI"

    test "163 is CLXIII":
      check roman(163) == "CLXIII"

    test "402 is CDII":
      check roman(402) == "CDII"

    test "575 is DLXXV":
      check roman(575) == "DLXXV"

    test "911 is CMXI":
      check roman(911) == "CMXI"

    test "1024 is MXXIV":
      check roman(1024) == "MXXIV"

    test "3000 is MMM":
      check roman(3000) == "MMM"

    test "16 is XVI":
      check roman(16) == "XVI"

    test "66 is LXVI":
      check roman(66) == "LXVI"

    test "166 is CLXVI":
      check roman(166) == "CLXVI"

    test "666 is DCLXVI":
      check roman(666) == "DCLXVI"

    test "1666 is MDCLXVI":
      check roman(1666) == "MDCLXVI"

    test "3001 is MMMI":
      check roman(3001) == "MMMI"

    test "3999 is MMMCMXCIX":
      check roman(3999) == "MMMCMXCIX"
