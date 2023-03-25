type
  Node = ref object # a reference to an object with the following fields:
    le, ri: Node    # left and right subtrees
    sym: ref Sym    # leaves contain a reference to a Sym

  Sym = object   # a symbol
    name: string # the symbol's name
    line: int    # the line the symbol was declared in
    code: Node   # the symbol's abstract syntax tree
