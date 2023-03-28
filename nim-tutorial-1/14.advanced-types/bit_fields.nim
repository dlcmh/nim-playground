import std/setutils

type
  MyFlag* = enum
    A
    B
    C
    D
  MyFlags = set[MyFlag]

proc toNum(f: MyFlags): int = cast[int](f)

let ALL_FLAGS_SET = toNum MyFlag.fullSet
echo "ALL_FLAGS_SET: ", ALL_FLAGS_SET

proc toFlags(v: int): MyFlags =
  if v > ALL_FLAGS_SET:
    return {A}
  cast[MyFlags](v)

echo toFlags 9999
echo toFlags 13
