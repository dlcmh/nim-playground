import std/strutils

proc isPangram(s: string): bool =
  result = true
  let l = s.toLowerAscii
  for c in {'a'..'z'}:
    if not l.contains c:
      echo c
      result = false
      break

echo isPangram("the quick brown fox jumps over the lazy dog")
