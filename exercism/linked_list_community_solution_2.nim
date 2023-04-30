type
  Node[T] = ref object
    val: T
    prev: Node[T]
    next: Node[T]
  LinkedList*[T] = object
    first: Node[T]
    last: Node[T]

proc len*[T](list: LinkedList[T]): int =
  var current = list.first
  while current != nil:
    inc result
    current = current.next

proc push*[T](list: var LinkedList[T], val: T) =
  var node = Node[T](val: val, prev: list.last, next: nil)
  if node.prev != nil:
    node.prev.next = node
  if list.first == nil:
    list.first = node
  list.last = node

proc pop*[T](list: var LinkedList[T]): T =
  let popped = list.last
  list.last = popped.prev
  if list.last == nil:
    list.first = nil
  else:
    list.last.next = nil
  popped.val

proc shift*[T](list: var LinkedList[T]): T =
  let shifted = list.first
  list.first = shifted.next
  if list.first != nil:
    list.first.prev = nil
  else:
    list.last = nil
  shifted.val

proc unshift*[T](list: var LinkedList[T], val: T) =
  var node = Node[T](val: val, prev: nil, next: list.first)
  if node.next != nil:
    node.next.prev = node
  list.first = node
  if list.last == nil:
    list.last = node

proc delete*[T](list: var LinkedList[T], val: T) =
  var current = list.first
  while current != nil:
    if current.val == val:
      if current == list.first:
        list.first = current.next
      else:
        current.prev.next = current.next
      if current == list.last:
        list.last = current.prev
      else:
        current.next.prev = current.prev
      return
    current = current.next

when isMainModule:
  import std/unittest

  suite "Linked List":
    test "pop gets element from the list":
      var list = LinkedList[int]()
      list.push(7)
      check list.pop() == 7

    test "push/pop respectively add/remove at the end of the list":
      var list = LinkedList[int]()
      list.push(11)
      list.push(13)
      check list.pop() == 13
      check list.pop() == 11

    test "shift gets an element from the list":
      var list = LinkedList[int]()
      list.push(17)
      check list.shift() == 17

    test "shift gets first element from the list":
      var list = LinkedList[int]()
      list.push(23)
      list.push(5)
      check list.shift() == 23
      check list.shift() == 5

    test "unshift adds element at start of the list":
      var list = LinkedList[int]()
      list.unshift(23)
      list.unshift(5)
      check list.shift() == 5
      check list.shift() == 23

    test "pop, push, shift, and unshift can be used in any order":
      var list = LinkedList[int]()
      list.push(1)
      list.push(2)
      check list.pop() == 2
      list.push(3)
      check list.shift() == 1
      list.unshift(4)
      list.push(5)
      check list.shift() == 4
      check list.pop() == 5
      check list.shift() == 3

    test "count an empty list":
      var list = LinkedList[int]()
      check list.len == 0

    test "count a list with items":
      var list = LinkedList[int]()
      list.push(37)
      list.push(1)
      check list.len == 2

    test "count is correct after mutation":
      var list = LinkedList[int]()
      list.push(31)
      check list.len == 1
      list.unshift(43)
      check list.len == 2
      discard list.shift()
      check list.len == 1
      discard list.pop()
      check list.len == 0

    test "popping to empty doesn't break the list":
      var list = LinkedList[int]()
      list.push(41)
      list.push(59)
      discard list.pop()
      discard list.pop()
      list.push(47)
      check list.len == 1
      check list.pop() == 47

    test "shifting to empty doesn't break the list":
      var list = LinkedList[int]()
      list.push(41)
      list.push(59)
      discard list.shift()
      discard list.shift()
      list.push(47)
      check list.len == 1
      check list.shift() == 47

    test "deletes the only element":
      var list = LinkedList[int]()
      list.push(61)
      list.delete(61)
      check list.len == 0

    test "deletes the element with the specified value from the list":
      var list = LinkedList[int]()
      list.push(71)
      list.push(83)
      list.push(79)
      list.delete(83)
      check list.len == 2
      check list.pop() == 79
      check list.shift() == 71

    test "deletes the element with the specified value from the list, re-assigns tail":
      var list = LinkedList[int]()
      list.push(71)
      list.push(83)
      list.push(79)
      list.delete(83)
      check list.len == 2
      check list.pop() == 79
      check list.pop() == 71

    test "deletes the element with the specified value from the list, re-assigns head":
      var list = LinkedList[int]()
      list.push(71)
      list.push(83)
      list.push(79)
      list.delete(83)
      check list.len == 2
      check list.shift() == 71
      check list.shift() == 79

    test "deletes the first of two elements":
      var list = LinkedList[int]()
      list.push(97)
      list.push(101)
      list.delete(97)
      check list.len == 1
      check list.pop() == 101

    test "deletes the second of two elements":
      var list = LinkedList[int]()
      list.push(97)
      list.push(101)
      list.delete(101)
      check list.len == 1
      check list.pop() == 97

    test "delete does not modify the list if the element is not found":
      var list = LinkedList[int]()
      list.push(89)
      list.delete(103)
      check list.len == 1

    test "deletes only the first occurrence":
      var list = LinkedList[int]()
      list.push(73)
      list.push(9)
      list.push(9)
      list.push(107)
      list.delete(9)
      check list.len == 3
      check list.pop() == 107
      check list.pop() == 9
      check list.pop() == 73
