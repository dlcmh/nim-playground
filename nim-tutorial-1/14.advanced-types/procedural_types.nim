proc greet(name: string): string =
  "Hello, " & name & "!"

proc bye(name: string): string =
  "Bye, " & name & "!"

proc communicate(greeting: proc (x: string): string, name: string) =
  echo greeting name

communicate(greet, "David") # Hello, David!
communicate(bye, "Kellie") # Bye, Kellie!
