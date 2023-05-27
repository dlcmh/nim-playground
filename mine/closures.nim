# {.nimcall.} and {.closure.} - Nim forum
# https://forum.nim-lang.org/t/6117
## to call a function it is necessary to know how (e.g. how should the parameters or the return value be transfered). This is what's called a calling convention.
## In practice you don't have to worry about this much, except when interfacing C or when dealing with closures like here.
## A reference to a closure is a bit different to a normal reference to a proc. Usually a single pointer pointing to the memory address where the proc begins is enough information to call it. But a closure is special because it's not only a proc, but it also has data associated with it captured by the proc.
## Here's an example of a closure:
proc testClosure(x: int): proc(): int =
  (proc(): int = x)

when isMainModule:
  # expression 'testClosure(9)' is of type 'proc (): int{.closure.}'
  # and has to be used (or discarded); for a function call use ()
  # testClosure(9)

  echo testClosure(9)() # 9
