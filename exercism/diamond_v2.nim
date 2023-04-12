import std/[sequtils, strutils]

proc diamond*(c: char): string =
  if c == 'A': return "A\n"
  let r = ('A' .. c).toSeq
  let width = r.len * 2 - 1
  var stack: seq[string]
  for i, c in r:
    var row = repeat(' ', width)
    let sideSpaces = (width div 2) - i
    row[sideSpaces] = c
    if i > 0:
      row[row.high - sideSpaces] = c
    result.add row
    result.add "\n"
    if i < r.high: stack.add row
  while stack.len > 0:
    result.add stack.pop
    result.add "\n"

when isMainModule:
  # doAssert diamond('A') == "A\n"
  # echo diamond('A')

  # doAssert diamond('B') == " A \n" & "B B\n" & " A \n"
  # echo diamond('B')

  # ..A..
  # .B.B.
  # C...C
  # .B.B.
  # ..A..
  echo diamond('C')

  # echo diamond('D')
