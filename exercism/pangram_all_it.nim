# https://exercism.org/tracks/nim/exercises/pangram/solutions/AtariRelic
import std/[sequtils, strutils]

proc isPangram(s: string): bool =
  {'a'..'z'}.allIt it in s.toLower

echo isPangram("the quick brown fox jumps over the lazy dog")
