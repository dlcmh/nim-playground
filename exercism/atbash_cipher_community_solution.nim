import std/[strutils, wordwrap]

proc decode*(input: string): string =
  let input = input.toLower
  for c in input:
    if c.isDigit: result.add(c)
    elif c.isAlphaAscii: result.add(chr(219 - ord(c)))

proc encode*(input: string): string =
  wrapWords(s = decode(input), maxLineWidth = 5, newLine = " ")


echo encode("mindblowingly")
echo decode("vcvix rhn")
