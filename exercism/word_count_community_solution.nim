import std/[sequtils, strutils, tables]

proc countWords*[string](s: string): CountTable[string] =
  var words = s.replace(",", " ").toLowerAscii.splitWhitespace
  words.applyIt(it.strip(chars = AllChars - Letters - Digits))
  words.toCountTable

var output = countWords("\'First: don\'t laugh. Then: don\'t cry. You\'re getting it.\'")
echo output
echo output.len

output = countWords("testing, 1, 2 testing")
echo output
echo output.len

output = countWords("car: carpet as java: javascript!!&@$%^&")
echo output
echo output.len

# {"getting": 1, "don\'t": 2, "cry": 1, "laugh": 1, "then": 1, "first": 1, "you\'re": 1, "it": 1}
# 8
# {"testing": 2, "1": 1, "2": 1}
# 3
# {"javascript": 1, "as": 1, "java": 1, "car": 1, "carpet": 1}
# 5
