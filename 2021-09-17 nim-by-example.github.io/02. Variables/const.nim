proc getAlphabet(): string =
  var accumulator = ""

  for letter in 'a'..'z':
    accumulator.add(letter)

  return accumulator

# Computed at compilation time
const alphabet = getAlphabet()

echo alphabet
