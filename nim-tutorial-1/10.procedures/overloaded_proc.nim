proc toString(x: int): string =
  if x < 0: "negative"
  elif x > 0: "positive"
  else: "zero"

proc toString(x: bool): string =
  if x: "yep"
  else: "nope"

echo toString(9) # positive
echo toString(false) # nope
