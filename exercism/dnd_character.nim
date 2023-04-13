import std/[algorithm, math, random]

randomize()

type
  Character* = object
    strength*: int
    dexterity*: int
    constitution*: int
    intelligence*: int
    wisdom*: int
    charisma*: int
    hitpoints*: int

proc ability*: int =
  var rolls: seq[int]
  for _ in 1 .. 4:
    rolls.add rand(1 .. 6)
  rolls.sort(order = Descending)
  sum(rolls[0 .. 2])

proc modifier*(n: int): int =
  floorDiv(n - 10, 2).float.floor.int

proc initCharacter*: Character =
  let c = ability()
  Character(
    strength: ability(),
    dexterity: ability(),
    constitution: c,
    intelligence: ability(),
    wisdom: ability(),
    charisma: ability(),
    hitpoints: 10 + c.modifier,
  )

when isMainModule:
  # doAssert modifier(3) == -4
  # echo modifier(3)

  # echo ability()

  echo initCharacter() # (strength: 6, dexterity: 13, constitution: 14, intelligence: 12, wisdom: 11, charisma: 13, hitpoints: 12)
