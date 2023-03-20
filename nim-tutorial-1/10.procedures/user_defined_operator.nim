## https://forum.nim-lang.org/t/5376
## Allowed characters - https://nim-lang.org/docs/manual.html#lexical-analysis-operators
iterator `...!!!===`*[T](a: T, b: T): T =
  var res = T(a)
  while res <= b:
    yield res
    inc res

for i in 0 ...!!!=== 5:
  echo i

## https://nim-by-example.github.io/procs/
proc `$`(a: array[2, array[2, int]]): string =
  result = ""
  for v in a:
    for vx in v:
      result.add($vx & ", ")
    result.add("\n")

echo [[1, 2], [3, 4]] # See varargs for
                      # how echo works
# 1, 2,
# 3, 4,

proc `^^^`(a, b: string): string =
  ## A confusingly named useless operator
  result = a[0] & b[high(b)]

echo "foo" ^^^ "bar" # fr
