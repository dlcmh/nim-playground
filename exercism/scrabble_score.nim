import std/[strutils]

# proc score*(word: string): int =
#   for c in word:
#     case c.toLowerAscii
#     of 'a', 'e', 'i', 'o', 'u',
#        'l', 'n', 'r', 's', 't':
#       result.inc 1
#     of 'd', 'g':
#       result.inc 2
#     of 'b', 'c', 'm', 'p':
#       result.inc 3
#     of 'f', 'h', 'v', 'w', 'y':
#       result.inc 4
#     of 'k':
#       result.inc 5
#     of 'j', 'x':
#       result.inc 8
#     of 'q', 'z':
#       result.inc 10
#     else: discard

proc score*(word: string): int =
  for c in word.toLowerAscii:
    if c in "aeioulnrst":
      result.inc 1
    elif c in "dg":
      result.inc 2
    elif c in "bcmp":
      result.inc 3
    elif c in "fhvwy":
      result.inc 4
    elif c == 'k':
      result.inc 5
    elif c in "jx":
      result.inc 8
    elif c in "qz":
      result.inc 10

echo score "at"
