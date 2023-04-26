import std/[sequtils, strutils]

const MaxNine = ["zero", "one", "two", "three", "four", "five", "six", "seven",
    "eight", "nine"]
const En = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
    "sixteen", "seventeen", "eighteen", "nineteen"]
const Ty = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty",
    "ninety"]
const Scale = ["hundred", "thousand", "million", "billion"]

func hundreds(n: int64): string =
  if n in 100 .. 999:
    result.add MaxNine[n div 100] & " " & Scale[0]
  let tens = n mod 100
  let lastDigit = tens mod 10
  if tens in 10 .. 19:
    result.add " " & En[lastDigit]
  elif tens in 20 .. 99:
    result.add " " & Ty[(tens div 10) - 2]
    if lastDigit > 0:
      result.add "-" & MaxNine[lastDigit]
  elif tens in 1 .. 9:
    result.add " " & MaxNine[tens]

proc say*(n: int64): string =
  if n notin 0 .. 999_000_000_000: raise new ValueError
  if n == 0:
    return MaxNine[0]
  let threes = insertSep($n).split("_").mapIt(it.parseInt.int64)
  if threes.len > 1:
    for i, num in threes[0 .. ^2]:
      if num > 0:
        result.add hundreds(num) & " " & Scale[threes.len - 1 - i] & " "
  if threes[^1] > 0:
    result.add hundreds(threes[^1])
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
