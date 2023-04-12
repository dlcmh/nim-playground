import std/[math, random]

randomize()

proc privateKey*(p: int): int =
  if p == 1: return 1
  rand(2 .. p - 1)

proc publicKey*(p, g, a: int): int =
  g ^ a mod p

proc secret*(p, bPub, a: int): int =
  bPub ^ a mod p

when isMainModule:
  # echo privateKey(47) # random number in the range 2 .. 47 - 1

  # doAssert publicKey(p, g, privateKey) == 8
  echo publicKey(23, 5, 6)
