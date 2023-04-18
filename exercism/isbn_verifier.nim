import std/[sequtils, strutils, sugar]

proc isValid*(s: string): bool =
  if s.replace("-", "").len != 10:
    return false
  let ints: seq[int] = collect:
    for i, c in s:
      if c in Digits + {'X'}:
        if c == 'X' and i < s.high:
          continue     # an 'X' can only occupy the last position
        if c == 'X':
          10
        else:
          parseInt($c) # `$` stringifies the char
  if ints.len != 10:
    return false
  var total: int
  for i, v in countdown(10, 1).toSeq:
    total += ints[i] * v
  total mod 11 == 0

when isMainModule:
  import unittest

  suite "ISBN Verifier":
    test "valid ISBN":
      check isValid("3-598-21508-8") == true

    test "invalid ISBN check digit":
      check isValid("3-598-21508-9") == false

    test "valid ISBN with a check digit of 10":
      check isValid("3-598-21507-X") == true

    test "check digit is a character other than X":
      check isValid("3-598-21507-A") == false

    test "invalid check digit in ISBN is not treated as zero":
      check isValid("4-598-21507-B") == false

    test "invalid character in ISBN is not treated as zero":
      check isValid("3-598-P1581-X") == false

    test "X is only valid as a check digit":
      check isValid("3-598-2X507-9") == false

    test "valid ISBN without separating dashes":
      check isValid("3598215088") == true

    test "ISBN without separating dashes and X as check digit":
      check isValid("359821507X") == true

    test "ISBN without check digit and dashes":
      check isValid("359821507") == false

    test "too long ISBN and no dashes":
      check isValid("3598215078X") == false

    test "too short ISBN":
      check isValid("00") == false

    test "ISBN without check digit":
      check isValid("3-598-21507") == false

    test "check digit of X should not be used for 0":
      check isValid("3-598-21515-X") == false

    test "empty ISBN":
      check isValid("") == false

    test "input is 9 characters":
      check isValid("134456729") == false

    test "invalid characters are not ignored after checking length":
      check isValid("3132P34035") == false

    test "invalid characters are not ignored before checking length":
      check isValid("3598P215088") == false

    test "input is too long but contains a valid ISBN":
      check isValid("98245726788") == false
