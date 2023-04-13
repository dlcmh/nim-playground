import std/[strutils, tables]

proc transform*(t: Table[int, seq[char]]): Table[char, int] =
  for k, chars in t:
    for c in chars:
      result[c.toLowerAscii] = k

when isMainModule:
  import std/[unittest]

  const input = {
      1: @['A']
    }.toTable
  let output = transform(input)
  check:
    output.len == 1
    output['a'] == 1
