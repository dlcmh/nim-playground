# The result variable need not be declared

proc getAlphabet(): string =
    for letter in 'a'..'z':
        result.add(letter)

echo "\n"
echo getAlphabet()
