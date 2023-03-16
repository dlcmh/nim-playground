# https://nim-by-example.github.io/seqs/
# Seqs, abbreviated from “sequence”, provide dynamically expandable storage.
# There are two ways to create seqs, with the `@` operator and with the `newSeq[T](n: int)` method.
# Once a seq is created, it can be modified using the `add(item: T)`, `delete(idx: int)`.
# The length of a seq can be found through `len: int`, and the maximum index through `high: int`.
# The standard `items: T` and `pairs: tuple[i: int, v: T]` iterators are also available.

# Parameters are immutable in the procedure body. By default, their value cannot be changed because this allows the compiler to implement parameter passing in the most efficient way. If a mutable variable is needed inside the procedure, it has to be declared with var in the procedure body. Shadowing the parameter name is possible, and actually an idiom:
proc printSeq(s: seq, nprinted: int = -1) =
  var nprinted = if nprinted == 1: s.len else: min(nprinted, s.len)
  for i in 0 ..< nprinted:
    echo s[i]

printSeq(@[1, 2, 3]) # nothing echoed
printSeq(@[1, 2, 3], 2) # echoes 1 2
