# This is a comment
echo "What's your name? "
var name: string = readLine(stdin)
echo "Hi, ", name, "!"

#[
  Run a debug version:

  ```
  nim c -r greetings.nim
  ```
]#

#[

  Compile a release version:

  ```
  nim c --define:release greetings.nim

  # or

  nim c -d:release greetings.nim
  ```
]#



#[
  Compile a release version to compare with unsafe languages like C:

  ```
  nim c -d:danger greetings.nim
  ```
]#
