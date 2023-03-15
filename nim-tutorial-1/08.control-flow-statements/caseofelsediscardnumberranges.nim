from std/strutils import parseInt

echo "Enter a number: "
let n = parseInt(readLine(stdin))
case n
of 0..2, 4..7:
  echo "The number is in the set: {0, 1, 2, 4, 5, 6, 7}"
of 3, 8:
  echo "The number is 3 or 8"
else:
  discard # a _do nothing_ statement
