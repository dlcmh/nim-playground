import std/[math, sequtils]

proc sum*(limit: int, factors: openArray[int]): int =
  var multiples: seq[int] = @[0]
  for f in factors:
    if f == 0: continue
    for i in countup(f, limit - 1, f):
      multiples.add(i)
  return sum(deduplicate(multiples))

echo sum(20, @[3, 5])
echo sum(1, @[3, 5])
