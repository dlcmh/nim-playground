import std/[strutils]

proc encode*(s: string): string =
  var length: int
  var run: char
  proc str(): string =
    if length == 0: return
    (if length > 1: $length else: "") & run
  for c in s:
    if length == 0:
      run = c
      length.inc
    elif c == run:
      length.inc
    else:
      result.add str()
      run = c
      length = 1
  result.add str()

proc decode*(s: string): string =
  var length: string
  for c in s:
    if c.isDigit:
      length.add c
    else:
      if length == "":
        result.add c
      else:
        result.add repeat(c, length.parseInt)
        length = ""

when isMainModule:
  import unittest

  suite "run-length encode a string":
    test "empty string":
      check encode("") == ""

    test "single characters only are encoded without count":
      check encode("XYZ") == "XYZ"

    test "string with no single characters":
      check encode("AABBBCCCC") == "2A3B4C"

    test "single characters mixed with repeated characters":
      let input = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
      let expected = "12WB12W3B24WB"
      check encode(input) == expected

    test "multiple whitespace mixed in string":
      check encode("  hsqq qww  ") == "2 hs2q q2w2 "

    test "lowercase characters":
      check encode("aabbbcccc") == "2a3b4c"


  suite "run-length decode a string":
    test "empty string":
      check decode("") == ""

    test "single characters only":
      check decode("XYZ") == "XYZ"

    test "string with no single characters":
      check decode("2A3B4C") == "AABBBCCCC"

    test "single characters with repeated characters":
      let input = "12WB12W3B24WB"
      let expected = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
      check decode(input) == expected

    test "multiple whitespace mixed in string":
      check decode("2 hs2q q2w2 ") == "  hsqq qww  "

    test "lowercase string":
      check decode("2a3b4c") == "aabbbcccc"


  suite "encode and then decode":
    test "encode followed by decode gives original string":
      check "zzz ZZ  zZ".encode.decode == "zzz ZZ  zZ"
