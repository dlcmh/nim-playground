## As mentioned earlier, the built-in `$` (stringify) operator turns any basic type into a string, which you can then print to the console using the echo proc.
## However, advanced types, and your own custom types, won't work with the `$` operator until you define it for them.
## Sometimes you just want to debug the current value of a complex type without having to write its `$` operator.
## You can use then the `repr` proc which works with any type and even complex data graphs with cycles.
## The following example shows that even for basic types there is a difference between the `$` and `repr` outputs:

let
  myBool = true
  myCharacter = 'n'
  myString = "nim"

echo myBool, ":", repr myBool # true:true
echo myCharacter, ":", repr myCharacter # n:'n'
echo myString, ":", repr myString # nim:0x10f4ec060"nim"
