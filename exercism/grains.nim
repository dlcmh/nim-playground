import std/[math]

proc onSquare*(n: int): uint64 =
  if n notin 1 .. 64: raise new ValueError
  2'u64 ^ (n - 1)

proc total*: uint64 =
  for i in 1 .. 64:
    result += onSquare(i)

echo onSquare(64) # 9223372036854775808
