import std/[strformat, sugar]

type
  Clock* = object
    hour*: range[0..23]
    minute*: range[0..59]
  Minutes* = distinct int

proc `$`*(c: Clock): string =
  "{c.hour:02}:{c.minute:02}".fmt

proc `+`*(c: Clock, v: Minutes): Clock =
  let totalMinutes = c.hour * 60 + c.minute + v.int
  var hoursFromMinutes = totalMinutes div 60
  let minute = totalMinutes mod 60
  if minute < 0:
    result.minute = 60 + minute
    hoursFromMinutes -= 1
  else:
    result.minute = minute
  let hours = hoursFromMinutes mod 24
  if hours >= 0:
    result.hour = hours
  elif hours < 0:
    result.hour = 24 + hours

proc `-`*(c: Clock, v: Minutes): Clock =
  c + Minutes(v.int)

proc initClock*(hour, minute: int): Clock =
  result = Clock(hour: 0, minute: 0) + Minutes(hour * 60 + minute)

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
