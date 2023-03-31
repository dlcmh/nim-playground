import std/[sequtils, sugar]

proc genCombos[T](items: seq[T], howMany: int): seq[T] =
  var arr = [0, 1, 2, 3]

  for a in arr.low .. items.high + 1 - howMany:
    dump a

    # arr[arr.low] = a
    for i in a .. howMany - 1:
      dump i

    for b in arr[arr.high] .. items.high:
      dump (a, b)
      arr[arr.high] = b
      dump arr

  items

discard @[0, 1, 2, 3, 4, 5].genCombos 4
