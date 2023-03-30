import std/strutils

proc abbreviate*(s: string): string =
  for word in s.split {' ', '-', '_'}:
    if word.isEmptyOrWhitespace: continue
    result.add word[0].toUpperAscii

when isMainModule:
  block: # ILN
    doAssert abbreviate("I - love _nuts_") == "ILN"
