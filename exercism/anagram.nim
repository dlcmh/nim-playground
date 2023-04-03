import std/[algorithm, strutils, sugar]

proc detectAnagrams*(word: string, candidates: openArray[string]): seq[string] =
  let lWord = word.toLowerAscii
  let wordLetters = lWord.sorted
  for c in candidates:
    if c.len != wordLetters.len: continue
    let lC = c.toLowerAscii
    if lC == lWord: continue
    var isAnagram = true
    for i, v in lC.sorted:
      if v != wordLetters[i]:
        isAnagram = false
        break
    if isAnagram: result.add c

dump detectAnagrams("good", ["dog"])
dump detectAnagrams("sTop", ["pots"])
dump detectAnagrams("sTop", ["sTop"])
