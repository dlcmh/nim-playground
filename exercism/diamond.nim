import std/[sequtils, strutils, strformat]

proc diamond*(c: char): string =
  if c == 'A': return "A\n"
  let r = ('A' .. c).toSeq
  let width = r.len * 2 - 1
  var stack: seq[string]
  for i, c in r:
    var row: string
    var sideSpaces, midSpaces: int
    if i == 0:
      sideSpaces = (width - 1) div 2
      row.add &"{repeat(' ', sideSpaces)}"
      row.add c
      row.add &"{repeat(' ', sideSpaces)}"
    else:
      midSpaces = i * 2 - 1
      sideSpaces = (width - 2 - midSpaces) div 2
      row.add &"{repeat(' ', sideSpaces)}"
      row.add c
      row.add &"{repeat(' ', midSpaces)}"
      row.add c
      row.add &"{repeat(' ', sideSpaces)}"
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
