import std/[tables, sequtils, sugar, unicode]

proc detectAnagrams*(word: string, candidates: openArray[string]): seq[string] =
  candidates.filterIt(
    it.toLower.toCountTable == word.toLower.toCountTable and
      word.toLower != it.toLower
    )

dump detectAnagrams("good", ["dog"])
dump detectAnagrams("sTop", ["pots"])
dump detectAnagrams("sTop", ["sTop"])
dump "sTop".toLower.toCountTable

# detectAnagrams("good", ["dog"]) = @[]
# detectAnagrams("sTop", ["pots"]) = @["pots"]
# detectAnagrams("sTop", ["sTop"]) = @[]
# "sTop".toLower.toCountTable = {'o': 1, 'p': 1, 's': 1, 't': 1}
