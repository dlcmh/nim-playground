block myblock:
  echo "entering block"
  while true:
    echo "looping"
    break # leaves the loop, but not the block
  echo "still in block"
echo "outside the block"

# to break out completely from inside nested loops, do a `break outermost`
block outermost:
  echo "entering block"
  while true:
    echo "looping"
    break outermost # leaves the block (and the loop)
  echo "still in block" # it won't be printed

echo "outside the block"
