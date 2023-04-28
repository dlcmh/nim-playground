type
  Planet* = enum
    Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune

const Factor = [Mercury: 0.2408467, Venus: 0.61519726, Earth: 1.0,
                Mars: 1.8808158, Jupiter: 11.862615, Saturn: 29.447498,
                Uranus: 84.016846, Neptune: 164.79132]
const SecondsPerYear = 365.25 * 24 * 60 * 60

proc age*(planet: Planet, seconds: int64): float =
  seconds.float / (Factor[planet] * SecondsPerYear)

when isMainModule:
  import unittest

  suite "Space Age":
    # Helper operator: return true when two floats are approximately equal
    func `~=`(x, y: float): bool =
      abs(x - y) < 0.01

    test "age on Earth":
      check age(Earth, 1_000_000_000) ~= 31.69

    test "age on Mercury":
      check age(Mercury, 2_134_835_688) ~= 280.88

    test "age on Venus":
      check age(Venus, 189_839_836) ~= 9.78

    test "age on Mars":
      check age(Mars, 2_129_871_239) ~= 35.88

    test "age on Jupiter":
      check age(Jupiter, 901_876_382) ~= 2.41

    test "age on Saturn":
      check age(Saturn, 2_000_000_000) ~= 2.15

    test "age on Uranus":
      check age(Uranus, 1_210_123_456) ~= 0.46

    test "age on Neptune":
      check age(Neptune, 1_821_023_456) ~= 0.35

    # Bonus
    test "age that requires int64":
      check age(Saturn, 3_000_000_000) ~= 3.23
