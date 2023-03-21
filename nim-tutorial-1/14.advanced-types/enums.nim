type
  Direction = enum
    north
    south
    east
    west

let x = Direction.west # just `west` is sufficient, but less clear

echo x, ":", repr x, ":", ord x # west:west:3

echo ord Direction.north # 0
