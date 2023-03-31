import std/sugar

proc combinations[T](items: seq[T], choose: int): seq[T] =
  ## init
  ## newSeq preallocates space
  result.newSeq choose
  var choices: seq[int]; choices.newSeq choose

  ## initial loop arguments
  var done = false
  var iteration = 1
  var highPosOffset = 1
  # dump highPosOffset

  ## generate initial set of choices
  for i in 0 .. choices.high:
    choices[i] = i
  # dump choices

  echo "\n==="

  while not done:
    ## generate combinations
    for i, e in choices:
      result[i] = items[e]

    dump iteration
    dump choices
    dump result
    echo "---"

    ##
    if choices[^highPosOffset] < items.high + 1 - highPosOffset:
      inc iteration
      inc choices[^highPosOffset]
      continue

    ##
    if highPosOffset < choices.len:
      ##
      inc iteration
      inc highPosOffset
      inc choices[^highPosOffset]

      ##
      # var incVal = choices[^highPosOffset] + 1
      # for i in countdown(highPosOffset - 1, 1):
      #   choices[^i] = incVal
      #   inc incVal

      continue

    done = true

discard @[0, 1, 2, 3, 4, 5].combinations 4
