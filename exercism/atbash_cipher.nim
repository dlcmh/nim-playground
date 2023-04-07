import std/[strutils]

const Plain = "abcdefghijklmnopqrstuvwxyz"
const Cipher = "zyxwvutsrqponmlkjihgfedcba"

proc encode*(s: string): string =
  var grouping = 0
  for c in s.toLowerAscii:
    if c notin Letters + Digits: continue
    let i = Plain.find c
    if grouping == 5:
      result.add ' '
      grouping = 0
    if i < 0:
      result.add c
    else:
      result.add Cipher[i]
    grouping.inc

proc decode*(s: string): string =
  for c in s:
    if c notin Letters + Digits: continue
    let i = Cipher.find c
    if i < 0:
      result.add c
    else:
      result.add Plain[i]

echo encode("mindblowingly")
echo decode("vcvix rhn")
