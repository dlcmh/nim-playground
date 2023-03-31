import std/[math, sequtils, sugar]

proc nChooseR(n: Positive, r: Positive): int =
  n.fac.floorDiv (r.fac * (n - r).fac)

proc genCombos[T](items: seq[T], howMany: int) =
  var combo = toSeq(0 .. howMany - 1)
  var iter = 1
  while iter <= nChooseR(items.len, howMany):
    if iter == 1:
      dump (iter, combo)
      iter.inc
      continue

    for i in countdown(combo.high, combo.low):
      if combo[i] < items.high - howMany + 1 + i:
        combo[i].inc

        for j, v in toSeq((i + 1) .. combo.high):
          combo[v] = combo[i] + j + 1

        break

    dump (iter, combo)
    iter.inc

toSeq(0 .. 7).genCombos 3
# (iter, combo) = (1, @[0, 1, 2])
# (iter, combo) = (2, @[0, 1, 3])
# (iter, combo) = (3, @[0, 1, 4])
# (iter, combo) = (4, @[0, 1, 5])
# (iter, combo) = (5, @[0, 1, 6])
# (iter, combo) = (6, @[0, 1, 7])
# (iter, combo) = (7, @[0, 2, 3])
# (iter, combo) = (8, @[0, 2, 4])
# (iter, combo) = (9, @[0, 2, 5])
# (iter, combo) = (10, @[0, 2, 6])
# (iter, combo) = (11, @[0, 2, 7])
# (iter, combo) = (12, @[0, 3, 4])
# (iter, combo) = (13, @[0, 3, 5])
# (iter, combo) = (14, @[0, 3, 6])
# (iter, combo) = (15, @[0, 3, 7])
# (iter, combo) = (16, @[0, 4, 5])
# (iter, combo) = (17, @[0, 4, 6])
# (iter, combo) = (18, @[0, 4, 7])
# (iter, combo) = (19, @[0, 5, 6])
# (iter, combo) = (20, @[0, 5, 7])
# (iter, combo) = (21, @[0, 6, 7])
# (iter, combo) = (22, @[1, 2, 3])
# (iter, combo) = (23, @[1, 2, 4])
# (iter, combo) = (24, @[1, 2, 5])
# (iter, combo) = (25, @[1, 2, 6])
# (iter, combo) = (26, @[1, 2, 7])
# (iter, combo) = (27, @[1, 3, 4])
# (iter, combo) = (28, @[1, 3, 5])
# (iter, combo) = (29, @[1, 3, 6])
# (iter, combo) = (30, @[1, 3, 7])
# (iter, combo) = (31, @[1, 4, 5])
# (iter, combo) = (32, @[1, 4, 6])
# (iter, combo) = (33, @[1, 4, 7])
# (iter, combo) = (34, @[1, 5, 6])
# (iter, combo) = (35, @[1, 5, 7])
# (iter, combo) = (36, @[1, 6, 7])
# (iter, combo) = (37, @[2, 3, 4])
# (iter, combo) = (38, @[2, 3, 5])
# (iter, combo) = (39, @[2, 3, 6])
# (iter, combo) = (40, @[2, 3, 7])
# (iter, combo) = (41, @[2, 4, 5])
# (iter, combo) = (42, @[2, 4, 6])
# (iter, combo) = (43, @[2, 4, 7])
# (iter, combo) = (44, @[2, 5, 6])
# (iter, combo) = (45, @[2, 5, 7])
# (iter, combo) = (46, @[2, 6, 7])
# (iter, combo) = (47, @[3, 4, 5])
# (iter, combo) = (48, @[3, 4, 6])
# (iter, combo) = (49, @[3, 4, 7])
# (iter, combo) = (50, @[3, 5, 6])
# (iter, combo) = (51, @[3, 5, 7])
# (iter, combo) = (52, @[3, 6, 7])
# (iter, combo) = (53, @[4, 5, 6])
# (iter, combo) = (54, @[4, 5, 7])
# (iter, combo) = (55, @[4, 6, 7])
# (iter, combo) = (56, @[5, 6, 7])
