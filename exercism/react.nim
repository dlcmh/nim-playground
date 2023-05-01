import std/[lists, sequtils]

type
  ComputeFunc = proc(vals: seq[int]): int {.noSideEffect.}
  Callback = proc(val: int)
  CellKind = enum
    ckInput, ckReactive
  Cell = ref object
    val: int
    dependents: seq[Cell]
    case kind: CellKind
      of ckReactive:
        dependencies: seq[Cell]
        compute: ComputeFunc
        callbacks: DoublyLinkedList[Callback]
        diff: int
      else:
        discard

proc newInputCell*(val: int): Cell =
  Cell(val: val, kind: ckInput)

proc value*(cell: Cell): int =
  cell.val

proc computeDependents(cell: Cell) =
  var stack = @[cell]
  var cbQ: seq[Cell]
  while stack.len > 0:
    var cell = stack.pop
    let old = cell.val
    if cell.kind == ckReactive:
      cell.val = cell.compute(cell.dependencies.mapIt(it.val))
      if cell.val != old:
        cell.diff += cell.val - old
        cbQ.add cell
    if cell.kind == ckInput or cell.val != old:
      stack &= cell.dependents
  for cell in cbQ:
    if cell.diff == 0: continue
    for cb in cell.callbacks:
      cb(cell.val)
    cell.diff = 0

proc `value=`*(cell: Cell, val: int) =
  let oldVal = cell.val
  cell.val = val
  if oldVal != val:
    cell.computeDependents

proc newComputeCell*(dependencies: seq[Cell],
                     compute: ComputeFunc): Cell =
  result = Cell(kind: ckReactive, dependencies: dependencies, compute: compute)
  result.computeDependents
  for dependency in dependencies:
    dependency.dependents.add result

proc addCallback*(cell: Cell, callback: Callback) =
  cell.callbacks.add callback

proc removeCallback*(cell: Cell, callback: Callback) =
  for node in nodes(cell.callbacks):
    if node.value == callback:
      cell.callbacks.remove node

when isMainModule:
  import unittest

  func firstPlusOne(vals: seq[int]): int =
    vals[0] + 1

  func firstPlusSecondBy10(vals: seq[int]): int =
    vals[0] + vals[1] * 10

  func firstBy2(vals: seq[int]): int =
    vals[0] * 2

  func firstBy30(vals: seq[int]): int =
    vals[0] * 30

  func firstPlusSecond(vals: seq[int]): int =
    vals[0] + vals[1]

  func onAtLeastThree222Else111(vals: seq[int]): int =
    if vals[0] >= 3: 222 else: 111

  func firstMinusOne(vals: seq[int]): int =
    vals[0] - 1

  func firstBySecond(vals: seq[int]): int =
    vals[0] * vals[1]

  func firstMinusSecond(vals: seq[int]): int =
    vals[0] - vals[1]

  suite "React":
    test "input cells have a value":
      var
        i1 = newInputCell(10)
      check i1.value == 10

    test "an input cell's value can be set":
      var
        i1 = newInputCell(4)
      i1.value = 20
      check i1.value == 20

    test "compute cells calculate initial value":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
      check c1.value == 2

    test "compute cells take inputs in the right order":
      var
        i1 = newInputCell(1)
        i2 = newInputCell(2)
        c1 = newComputeCell(@[i1, i2], firstPlusSecondBy10)
      check c1.value == 21

    test "compute cells update value when dependencies are changed":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
      i1.value = 3
      check c1.value == 4

    test "compute cells can depend on other compute cells":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstBy2)
        c2 = newComputeCell(@[i1], firstBy30)
        c3 = newComputeCell(@[c1, c2], firstPlusSecond)
      check c3.value == 32
      i1.value = 3
      check c3.value == 96

    test "compute cells fire callbacks":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        observed = newSeq[int]()
      c1.addCallback(proc(val: int) = add(observed, val))
      check observed.len == 0
      i1.value = 3
      check observed == @[4]

    test "callback cells only fire on change":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], onAtLeastThree222Else111)
        observed = newSeq[int]()
      c1.addCallback(proc(val: int) = add(observed, val))
      i1.value = 2
      check observed.len == 0
      i1.value = 4
      check observed == @[222]

    test "callbacks do not report already reported values":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        observed = newSeq[int]()
      c1.addCallback(proc(val: int) = add(observed, val))
      i1.value = 2
      check observed == @[3]
      i1.value = 3
      check observed == @[3, 4]

    test "callbacks can fire from multiple cells":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        c2 = newComputeCell(@[i1], firstMinusOne)
        observed1 = newSeq[int]()
        observed2 = newSeq[int]()
      c1.addCallback(proc(val: int) = add(observed1, val))
      c2.addCallback(proc(val: int) = add(observed2, val))
      i1.value = 10
      check observed1 == @[11]
      check observed2 == @[9]

    test "callbacks can be added and removed":
      var
        i1 = newInputCell(11)
        c1 = newComputeCell(@[i1], firstPlusOne)
        observed1 = newSeq[int]()
        observed2 = newSeq[int]()
      let
        cb1 = proc(val: int) = add(observed1, val)
        cb2 = proc(val: int) = add(observed2, val)
      c1.addCallback cb1
      c1.addCallback cb2
      i1.value = 31
      check observed1 == @[32]
      check observed2 == @[32]
      c1.removeCallback cb1
      var
        observed3 = newSeq[int]()
        cb3 = proc(val: int) = add(observed3, val)
      c1.addCallback cb3
      i1.value = 41
      check observed1 == @[32]
      check observed2 == @[32, 42]
      check observed3 == @[42]

    test "removing a callback multiple times doesn't interfere with other callbacks":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        observed1 = newSeq[int]()
        observed2 = newSeq[int]()
      let
        cb1 = proc(val: int) = add(observed1, val)
        cb2 = proc(val: int) = add(observed2, val)
      c1.addCallback cb1
      c1.addCallback cb2
      c1.removeCallback cb1
      c1.removeCallback cb1
      c1.removeCallback cb1
      i1.value = 2
      check observed1.len == 0
      check observed2 == @[3]

    test "callbacks should only be called once even if multiple dependencies change":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        c2 = newComputeCell(@[i1], firstMinusOne)
        c3 = newComputeCell(@[c2], firstMinusOne)
        c4 = newComputeCell(@[c1, c3], firstBySecond)
        observed = newSeq[int]()
      c4.addCallback(proc(val: int) = add(observed, val))
      i1.value = 4
      check observed == @[10]

    test "callbacks should not be called if dependencies change but " &
         "output value doesn't change":
      var
        i1 = newInputCell(1)
        c1 = newComputeCell(@[i1], firstPlusOne)
        c2 = newComputeCell(@[i1], firstMinusOne)
        c3 = newComputeCell(@[c1, c2], firstMinusSecond)
        observed = newSeq[int]()
      c3.addCallback(proc(val: int) = add(observed, val))
      for i in 2..5:
        i1.value = i
        check observed.len == 0
