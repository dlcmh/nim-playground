import std/[math, strutils, sugar]

proc isValid*(s: string): bool =
  let s = s.replace(" ", "")
  var nums = collect:
    for c in s:
      if c notin Digits: continue
      parseInt($c)
  if nums.len < s.len or nums.len <= 1: return
  for i in 1 .. nums.len div 2:
    var doubled = nums[^(i * 2)] * 2
    if doubled > 9: doubled -= 9
    nums[^(i * 2)] = doubled
  nums.sum mod 10 == 0

when isMainModule:
  import std/[unittest]

  suite "Luhn":
    test "single digit strings can not be valid":
      check isValid("1") == false

    test "a single zero is invalid":
      check isValid("0") == false

    test "a simple valid SIN that remains valid if reversed":
      check isValid("059") == true

    test "a simple valid SIN that becomes invalid if reversed":
      check isValid("59") == true

    test "a valid Canadian SIN":
      check isValid("055 444 285") == true

    test "invalid Canadian SIN":
      check isValid("055 444 286") == false

    test "invalid credit card":
      check isValid("8273 1232 7352 0569") == false

    test "invalid long number with an even remainder":
      check isValid("1 2345 6789 1234 5678 9012") == false

    test "invalid long number with a remainder divisible by 5":
      check isValid("1 2345 6789 1234 5678 9013") == false

    test "valid number with an even number of digits":
      check isValid("095 245 88") == true

    test "valid number with an odd number of spaces":
      check isValid("234 567 891 234") == true

    test "valid strings with a non-digit added at the end become invalid":
      check isValid("059a") == false

    test "valid strings with punctuation included become invalid":
      check isValid("055-444-285") == false

    test "valid strings with symbols included become invalid":
      check isValid("055# 444$ 285") == false

    test "single zero with space is invalid":
      check isValid(" 0") == false

    test "more than a single zero is valid":
      check isValid("0000 0") == true

    test "input digit 9 is correctly converted to output digit 9":
      check isValid("091") == true

    test "very long input is valid":
      check isValid("9999999999 9999999999 9999999999 9999999999") == true

    test "valid luhn with an odd number of digits and non zero first digit":
      check isValid("109") == true

    test "using ascii value for non-doubled non-digit isn't allowed":
      check isValid("055b 444 285") == false

    test "using ascii value for doubled non-digit isn't allowed":
      check isValid(":9") == false

    test "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed":
      check isValid("59%59") == false
