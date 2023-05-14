import std/[hashes, sets, tables]

## page 114:
## The hashes module is necessary to aid in computing a hash in the hash
## procedure. It defines the Hash type, the hash procedure for many common types
## including string, and the !$ operator. The !$ operator finalizes the computed
## hash, which is necessary when writing a custom hash procedure.
## The use of the !$ operator ensures that the computed hash is unique.

type
  Dog = object
    name: string

proc hash(x: Dog): Hash =
  result = x.name.hash # Uses the Dog’s name field to compute a hash
  result = !$result # Uses the !$ operator to finalize the computed hash

var dogOwners = initTable[Dog, string]()
dogOwners[Dog(name: "Charlie")] = "John"

echo dogOwners[Dog(name: "Charlie")] # John
echo dogOwners # {(name: "Charlie"): "John"}

## page 115:  Just like the Table[A,B] type, the HashSet[A] type requires a hash
## procedure for the type A to be defined.
var dogAccess = toHashSet [Dog(name: "Charlie"), Dog(name: "Charlie")]
echo dogAccess # {(name: "Charlie")}

dogAccess.incl Dog(name: "Leslie")
echo dogAccess # {(name: "Charlie"), (name: "Leslie")}
