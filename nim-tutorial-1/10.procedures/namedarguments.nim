proc p(first, second, third, fourth: string) =
  echo "first: ", first
  echo "second: ", second
  echo "third: ", third
  echo "fourth: ", fourth

## compiler checks that each parameter receives exactly one argument
## Now that we use named arguments to call p the argument order does not matter anymore.
## Mixing named arguments with ordered arguments is also possible, but not very readable:
p("1", third = "3", second = "2", "4")
# first: 1
# second: 2
# third: 3
# fourth: 4
