## The empty `[]` subscript notation can be used to de-refer a reference, meaning to retrieve the item the reference points to.
## The `.` (access a tuple/object field operator) and `[]` (array/string/sequence index operator) operators perform implicit dereferencing operations for reference types:
type
  Node = ref object
    le, ri: Node
    data: int
var n = Node(data: 9)

# no need to write n[].data; in fact n[].data is highly discouraged!
echo n.data # 9

## To allocate a new traced object, the built-in procedure `new` can be used:
var m: Node
new(m)
echo m.data # 0
m = Node(data: 10)
echo m.data # 10
