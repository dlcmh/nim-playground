import std/strutils

proc isIsogram*(s: string): bool =
  result = true

  if s == "": return

  let l = s.toLowerAscii

  for i, c in l[0 .. ^2]:
    if c in ['-', ' ']: continue
    if l[i + 1 .. ^1].contains(c):
      return false

when isMainModule:
  block: # not an isogram
    doAssert isIsogram("isograms") == false
  block: # is an isogram
    doAssert isIsogram("lumberjack") == true
  block: # string with spaces is an isogram
    doAssert isIsogram("Emily Jung Schwartzkopf") == true
