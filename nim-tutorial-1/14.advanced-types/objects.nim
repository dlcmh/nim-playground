import std/with

type
  Human = object
    name: string
    age: int
let human1 = Human(age: 30)
echo human1 # (name: "", age: 30)

proc initHuman(name: string = "No name", age: int): Human =
  # Method 1
  # Human(name: name, age: age)

  # Method 2
  # https://ssalewski.de/nimprogramming.html#_objects
  var obj: Human
  with obj:
    name = name
    age = age
  return obj


let human2 = initHuman(age = 99)
echo human2 # (name: "No name", age: 99)
