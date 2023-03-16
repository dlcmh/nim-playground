proc p(x, y: int): int =
  x + y

echo p(1, 2) # echoes 3

# p(1, 2) # Error: expression 'p(1, 2)' is of type 'int' and has to be used (or discarded)

## To call a procedure that returns a value just for its side effects and ignoring its return value, a discard statement must be used.
## Nim does not allow silently throwing away a return value:
discard p(1, 2) # runs proces

## The return value can be ignored implicitly if the called proc/iterator has been declared with the discardable pragma:
proc q(x, y: int): int {.discardable.} =
  x + y

q(1, 2) # allowed
