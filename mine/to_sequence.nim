import std/[sequtils, sugar]

proc genSequence[T](items: openArray[T], howMany: int) =
  var combo = newSeq[T](howMany)

  for a in 0 .. 2:
    dump a

    for i, v in toSeq(a .. a + howMany - 1):
      # dump (i, v)
      combo[i] = v

    dump combo

    for b in combo[combo.high] + 1 .. items.high:
      # dump b
      combo[combo.high] = b

      dump combo

genSequence(toSeq(0 .. 5), 4)
