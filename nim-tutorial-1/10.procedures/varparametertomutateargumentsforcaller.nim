proc divmod(a, b: int; res, remainder: var int) =
  res = a div b # integer division
  remainder = a mod b # integer modulo operation

var
  x, y: int

divmod(8, 5, x, y)
echo x # echoes 1
echo y # echoes 3

# In the example, `res` and `remainder` are `var parameters`. Var parameters can be modified by the procedure and the changes are visible to the caller.
# Note that the above example would better make use of a tuple as a return value instead of using var parameters.
