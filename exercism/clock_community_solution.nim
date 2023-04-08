import std/[math, strformat, sugar]

type
  Clock* = object
    hour*: range[0..23]
    minute*: range[0..59]
  Minutes* = distinct int

proc initClock*(hour, minute: int): Clock =
  let totalMinutes = (hour * 60 + minute).euclMod(24 * 60)
  return Clock(hour: totalMinutes div 60, minute: totalMinutes mod 60)

proc `$`*(c: Clock): string =
  result = fmt"{c.hour:02}:{c.minute:02}"

proc `+`*(c: Clock, v: Minutes): Clock =
  return initClock(c.hour, c.minute + v.int)

proc `-`*(c: Clock, v: Minutes): Clock =
  return initClock(c.hour, c.minute - v.int)

dump initClock(0, 100) # "01:40"
dump initClock(0, 1000) # "16:40"
dump initClock(0, 1440) # "00:00"
dump initClock(0, 0) # "00:00"
dump initClock(-1, 0) # "23:00"
dump initClock(-1, -10) # "22:50"
dump initClock(0, -100) # "22:20"
dump initClock(-1, -100) # "21:20"
dump initClock(-54, -11513) # "21:20"
dump initClock(10, 0) + Minutes(3) # "10:03"
dump initClock(10, 3) - Minutes(3) # "10:00"
dump initClock(6, 41) # "06:41"
dump initClock(6, 41) + 0.Minutes # "06:41"
