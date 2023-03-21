var nat: Natural = 40
# nat = -1 # Error: conversion from int literal(-1) to Natural is invalid
echo nat

echo high int # 9223372036854775807

type MySubrange = range[0 .. 5]
# let subrange: MySubrange = 15 # Error: conversion from int literal(15) to MySubrange is invalid
let subrange: MySubrange = 4
echo subrange # 4

type
  Direction = enum
    north
    south
    east
    west
type NorthSouth = range[Direction.north .. Direction.south]
# let directions: NorthSouth = Direction.east # Error: conversion from Direction to NorthSouth is invalid
let directions: NorthSouth = Direction.north
echo directions # north
