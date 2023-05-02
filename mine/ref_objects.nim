type
  RootCell = ref object of RootObj
    val0: int
  InputCell = ref object of RootCell
    val1: int
  ComputeCell = ref object of RootCell
    val2: int
  Cell = InputCell | ComputeCell

proc hi(cell: Cell) =
  echo type(cell)
  when cell is ComputeCell:
    echo cell.val0
    echo cell.val2
  elif cell is InputCell:
    echo cell.val0
    echo cell.val1

let c1 = InputCell(val1: 10)
let c2 = ComputeCell(val2: 100)
let c3 = ComputeCell(val0: 200)

c1.hi
c2.hi
c3.hi
