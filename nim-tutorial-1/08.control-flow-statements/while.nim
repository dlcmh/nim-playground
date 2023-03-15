## The example uses a while loop to keep asking the users for their name, as long as the user types in nothing (only presses RETURN).

echo "What's your name? "
var name = readLine(stdin)
while name == "":
  echo "Please tell me your name: "
  name = readLine(stdin) # no `var`, because we do not declare a new variable here
