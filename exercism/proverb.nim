proc recite*(words: openArray[string]): string =
  if words.len == 0: return
  if words.len > 1:
    var i: int
    while i < words.high:
      result.add "For want of a " &
        words[i] & " the " & words[i + 1] & " was lost.\n"
      i.inc
  result.add "And all for the want of a " & words[0] & "."

when isMainModule:
  import unittest

  suite "Proverb":
    test "zero pieces":
      const words: seq[string] = @[]
      const expected = ""
      check recite(words) == expected

    test "one piece":
      const words = @["nail"]
      const expected = "And all for the want of a nail."
      check recite(words) == expected

    test "two pieces":
      const words = @["nail", "shoe"]
      const expected = "For want of a nail the shoe was lost.\n" &
                      "And all for the want of a nail."
      check recite(words) == expected

    test "three pieces":
      const words = @["nail", "shoe", "horse"]
      const expected = "For want of a nail the shoe was lost.\n" &
                      "For want of a shoe the horse was lost.\n" &
                      "And all for the want of a nail."
      check recite(words) == expected

    test "full proverb":
      const words = @["nail", "shoe", "horse", "rider",
                      "message", "battle", "kingdom"]
      const expected = "For want of a nail the shoe was lost.\n" &
                      "For want of a shoe the horse was lost.\n" &
                      "For want of a horse the rider was lost.\n" &
                      "For want of a rider the message was lost.\n" &
                      "For want of a message the battle was lost.\n" &
                      "For want of a battle the kingdom was lost.\n" &
                      "And all for the want of a nail."
      check recite(words) == expected

    test "four pieces modernized":
      const words = @["pin", "gun", "soldier", "battle"]
      const expected = "For want of a pin the gun was lost.\n" &
                      "For want of a gun the soldier was lost.\n" &
                      "For want of a soldier the battle was lost.\n" &
                      "And all for the want of a pin."
      check recite(words) == expected
