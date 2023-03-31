import std/sugar

proc genCombos[T](items: seq[T], howMany: int): seq[T] =
  var iter = 0 # tracks iteration
  var combos: seq[int]; newSeq(combos,
      howMany) # allocate array to hold combos of item positions

  var genInitialCombo = true
  var i = 0
  while genInitialCombo:
    combos[i] = i
    if i + 1 < howMany:
      inc i
      continue
    genInitialCombo = false
    # dump combos

  echo "\n---"

  var incComboElem = true
  var comboElemPos = combos.high
  var maxItemPos = items.high + 1 - howMany + comboElemPos
  while incComboElem:
    iter.inc

    dump iter
    dump comboElemPos
    dump maxItemPos
    dump combos
    echo "---"

    if iter == 10:
      incComboElem = false

    var comboElemVal = combos[comboElemPos]

    if comboElemVal < maxItemPos:
      combos[comboElemPos].inc
      continue
    elif comboElemVal == maxItemPos:
      if comboElemPos == 0:
        incComboElem = false
        continue
      else:
        comboElemPos.dec
        combos[comboElemPos].inc
        maxItemPos = items.high + 1 - howMany + comboElemPos

        var resetPos = comboElemPos + 1
        var resetVal = combos[comboElemPos] + 1
        var resetComboPos = true
        while resetComboPos:
          combos[resetPos] = resetVal
          if resetPos < combos.high:
            resetPos.inc
            resetVal.inc
            continue
          else:
            comboElemPos = resetPos
            maxItemPos = items.high + 1 - howMany + comboElemPos
            resetComboPos = false

        continue

  items

discard @[0, 1, 2, 3, 4, 5].genCombos 4
