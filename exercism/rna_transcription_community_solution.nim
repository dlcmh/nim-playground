import strutils

proc toRna*(dna: string): string =
  if not dna.allCharsInSet({'C', 'G', 'T', 'A'}):
    raise newException(ValueError, "invalid nucleotide")
  dna.multiReplace(("C", "G"), ("G", "C"), ("T", "A"), ("A", "U"))

when isMainModule:
  import unittest

  suite "RNA Transcription":
    test "empty RNA sequence":
      check toRna("") == ""

    test "RNA complement of cytosine is guanine":
      check toRna("C") == "G"

    test "RNA complement of guanine is cytosine":
      check toRna("G") == "C"

    test "RNA complement of thymine is adenine":
      check toRna("T") == "A"

    test "RNA complement of adenine is uracil":
      check toRna("A") == "U"

    test "RNA complement":
      check toRna("ACGTGGTCTTAA") == "UGCACCAGAAUU"

    test "raise ValueError on invalid nucleotide":
      expect(ValueError):
        discard toRna("Q")
