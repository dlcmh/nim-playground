type
   Node = object
      value: string
      active: bool

proc activate(node: var Node) =
   node.active = true

# This can then be instantiated.
var knot = Node(value: "slip")

# You can print the attributes of an object.
echo knot

activate(knot)
echo knot
