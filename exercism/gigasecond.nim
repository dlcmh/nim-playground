import std/[math, times]

# 1 followed by 9 zeros
const gigasecond = 1 * 10 ^ 9

proc addGigasecond*(dt: DateTime): DateTime =
  dt + gigasecond.seconds

when isMainModule:
  import std/[unittest]

  let moment = dateTime(2015, mJan, 24, 23, 59, 59, zone = utc())
  let expected = dateTime(2046, mOct, 3, 1, 46, 39, zone = utc())
  check addGigasecond(moment) == expected
