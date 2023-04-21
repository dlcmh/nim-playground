import std/[math]

proc prime*(n: int): int =
  if n == 0: raise new ValueError
  if n == 1: return 2
  var oddNumber = 3
  var cnt = 1
  while cnt < n:
    # echo "num: ", num, " ", "cnt: ", cnt
    var isPrime = true
    for odd in countup(3, float(oddNumber).sqrt.ceil.int, 2):
      if oddNumber mod odd == 0:
        isPrime = false
        break
    if isPrime:
      result = oddNumber
      cnt.inc
    oddNumber += 2

# There are many algorithms to determine if a number is prime, but one of the simplest and most well-known is the trial division algorithm. Here are the steps:

# 1. Check if the number is less than 2. If so, it is not prime.
# 2. Check if the number is equal to 2. If so, it is prime.
# 3. Check if the number is even (i.e., its last digit is 0, 2, 4, 6, or 8). If so, it is not prime (except for 2).
# 4. Iterate over all odd integers greater than or equal to 3 up to the square root of the number. For each integer, check if it divides the number exactly. If so, the number is not prime.
# 5. If none of the integers from step 4 divide the number exactly, the number is prime.

proc primeV1*(n: int): int =
  if n == 0: raise new ValueError
  var num, cnt = 0
  while cnt < n:
    # echo "num: ", num, " ", "cnt: ", cnt
    if num < 2: discard
    elif num == 2:
      result = num
      cnt.inc
    elif num mod 2 == 0: discard
    else:
      var isPrime = true
      for i in countup(3, float(num).sqrt.int + 1, 2):
        if num mod i == 0:
          isPrime = false
          break
      if isPrime:
        result = num
        cnt.inc
    num.inc

when isMainModule:
  echo prime(1) # 2
  echo prime(2) # 3
  echo prime(6) # 13
  echo prime(10_001) # 104_743
  # import unittest

  # suite "Nth Prime":
  #   test "first prime":
  #     check prime(1) == 2

  #   test "second prime":
  #     check prime(2) == 3

  #   test "sixth prime":
  #     check prime(6) == 13

  #   test "big prime":
  #     check prime(10_001) == 104_743

  #   test "there is no zeroth prime":
  #     expect(ValueError):
  #       discard prime(0)
