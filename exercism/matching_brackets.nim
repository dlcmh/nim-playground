import std/unittest

proc isPaired*(s: string): bool =
  var stack: seq[char]
  for v in s:
    case v
    of '(': stack.add ')'
    of '[': stack.add ']'
    of '{': stack.add '}'
    of ')', ']', '}':
      if stack.len < 1 or v != stack.pop: return false
    else: discard
  stack.len == 0

check isPaired("{)()") == false
