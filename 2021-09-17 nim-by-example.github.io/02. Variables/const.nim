# Computed at compilation time

proc getAlphabet(): string =
  var accumulator = ""

  for letter in 'a'..'z':
    accumulator.add(letter)

  return accumulator
