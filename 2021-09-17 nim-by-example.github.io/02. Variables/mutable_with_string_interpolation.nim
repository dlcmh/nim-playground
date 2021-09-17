# Mutable variables with string interpolation

var
  a = "foo"
  b = 10

  # Works fine, initialized to 0
  c: int

# https://nim-lang.org/docs/strformat.html
import strformat

echo "\nwith `strformat`"

echo "a: {a}".fmt
echo "b: {b}".fmt
echo "c: {c}".fmt

# Mutate the variables
a.add("bar")
b += 1
c = 3

# https://stackoverflow.com/questions/58739226/how-do-you-do-string-interpolation-with-variables-in-nim
import strutils

echo "\nwith `strutils`"

let message = "$#, $#, $#"
let interpolation = message % [a, "{b}".fmt, "{c}".fmt]
echo interpolation
