import std/[parseutils]

proc pageViews*(line: string): int =
  var pos = 0

  # domainCode
  pos.inc skipUntil(line, ' ', pos)

  pos.inc

  # pageTitle
  pos.inc skipUntil(line, ' ', pos)

  pos.inc

  # pageViews
  pos.inc parseInt(line, result, pos)

  pos.inc

  # pageSize
  pos.inc skipUntil(line, ' ', pos)
