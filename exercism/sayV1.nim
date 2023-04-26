import std/[strutils]

const TenAndLess = [(0, "zero"), (1, "one"), (2, "two"), (3, "three"), (4,
    "four"), (5, "five"), (6, "six"), (7, "seven"), (8, "eight"), (9, "nine"),
    (10, "ten")]
const Teenth = [(1, "eleven"), (2, "twelve"), (3, "thirteen"), (4, "fourteen"),
    (15, "fifteen"), (6, "sixteen"), (7, "seventeen"), (8, "eighteen"),
    (9, "nineteen")]
const Ty = [(2, "twenty"), (3, "thirty"), (4, "forty"), (5, "fifty"), (6,
    "sixty"), (7, "seventy"), (8, "eighty"), (9, "ninety")]

proc say*(n: int64): string =
  func tenAndLess(n: int64): string =
    for v in TenAndLess:
      if v[0] == n:
        result.add v[1]
        break
  func elevenToNinetyNine(n: int64): string =
    let q = n div 10
    let r = n mod 10
    if q == 1:
      for v in Teenth:
        if v[0] == r:
          result.add v[1]
          break
    else:
      for v in Ty:
        if v[0] == q:
          result.add v[1]
          break
      if r == 0:
        discard
      else:
        result.add "-" & tenAndLess(r)
  func hundreds(n: int64): string =
    let q = n div 100
    let r = n mod 100
    if q > 0:
      result.add tenAndLess(q) & " hundred"
    if r in 11 .. 99:
      result.add " " & elevenToNinetyNine(r)
    elif r in 1 .. 10:
      result.add " " & tenAndLess(r)
  func thousands(n: int64): string =
    let q = n div 1000
    let r = n mod 1000
    if q > 0:
      result.add hundreds(q) & " thousand"
    if r > 0:
      result.add " " & hundreds(r)
  func millions(n: int64): string =
    let q = n div 1_000_000
    let r = n mod 1_000_000
    result.add hundreds(q) & " million"
    if r > 0:
      result.add " " & thousands(r)
  func billions(n: int64): string =
    let q = n div 1_000_000_000
    let r = n mod 1_000_000_000
    result.add hundreds(q) & " billion"
    if r > 0:
      result.add " " & millions(r)
  if n in 0 .. 10: result.add tenAndLess(n)
  elif n in 11 .. 99: result.add elevenToNinetyNine(n)
  elif n in 100 .. 999: result.add hundreds(n)
  elif n in 1000 .. 999_999: result.add thousands(n)
  elif n in 1_000_000 .. 999_999_999: result.add millions(n)
  elif n in 1_000_000_000 .. 999_999_999_999: result.add billions(n)
  else: raise new ValueError
  result.splitWhitespace.join(" ")

when isMainModule:
  # echo say(987_654_321_123)
  import unittest

  suite "Say":
    test "zero":
      check say(0) == "zero"

    test "one":
      check say(1) == "one"

    test "fourteen":
      check say(14) == "fourteen"

    test "twenty":
      check say(20) == "twenty"

    test "twenty-two":
      check say(22) == "twenty-two"

    test "thirty":
      check say(30) == "thirty"

    test "ninety-nine":
      check say(99) == "ninety-nine"

    test "one hundred":
      check say(100) == "one hundred"

    test "one hundred twenty-three":
      check say(123) == "one hundred twenty-three"

    test "two hundred":
      check say(200) == "two hundred"

    test "nine hundred ninety-nine":
      check say(999) == "nine hundred ninety-nine"

    test "one thousand":
      check say(1000) == "one thousand"

    test "one thousand two hundred thirty-four":
      check say(1234) == "one thousand two hundred thirty-four"

    test "one million":
      check say(1_000_000) == "one million"

    test "one million two thousand three hundred forty-five":
      check say(1_002_345) == "one million two thousand three hundred forty-five"

    test "one billion":
      check say(1_000_000_000) == "one billion"

    test "a big number":
      check say(987_654_321_123) == "nine hundred eighty-seven billion " &
                                    "six hundred fifty-four million " &
                                    "three hundred twenty-one thousand " &
                                    "one hundred twenty-three"

    test "numbers below zero are out of range":
      expect ValueError:
        discard say(-1)

    test "numbers above 999,999,999,999 are out of range":
      expect ValueError:
        discard say(1_000_000_000_000)
