import std/[math, sequtils, strutils]

proc encrypt*(s: string): string =
  var text: string
  for c in s.toLowerAscii:
    if c in Letters + Digits: text.add c
  if text.isEmptyOrWhitespace: return
  let l = text.len.float
  let c = l.sqrt.ceil
  var r = l.sqrt.floor
  while c * r < l: r += 1
  var stack = @text.distribute(r.int, spread = false)
  var col = 0
  while col < c.int:
    for row in stack:
      if col > row.len - 1:
        result.add ' '
        continue
      result.add row[col]
    col += 1
    if col < c.int: result.add ' '


when isMainModule:
  # doAssert encrypt("This is fun!") == "tsf hiu isn"
  # echo encrypt("This is fun!")

  # doAssert encrypt("Chill out.") == "clu hlt io "
  # echo encrypt("Chill out.")

  # doAssert encrypt("If man was meant to stay on the ground, god would have given us roots.") == "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
  echo encrypt("If man was meant to stay on the ground, god would have given us roots.") # imtgdvu fearwes mayoogr anouuio ntnnlvo wttddet aohghns sseoa
