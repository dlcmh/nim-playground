## Here `odd` depends on `even` and vice versa.
## Thus `even` needs to be introduced to the compiler before it is completely defined.
## The syntax for such a forward declaration is simple: just omit the `=` and the procedure's body
##
# forward declaration:
proc even(n: int): bool

proc odd(n: int): bool =
  assert(n >= 0) # makes sure we don't run into negative recursion
  if n == 0: false
  else:
    n == 1 or even(n-1)

proc even(n: int): bool =
  assert(n >= 0) # makes sure we don't run into negative recursion
  if n == 1: false
  else:
    n == 0 or odd(n-1)

echo even 7 # false
echo odd 2 # false
echo odd 3 # true
echo odd -3 # Error: unhandled exception: `n >= 0` [AssertionDefect]
