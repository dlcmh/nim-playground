import std/[parseutils]

var domainCode = ""
var pageTitle = ""
var pageSize = 0

proc pageViews*(line: string): int =
  var pos = 0

  pos.inc parseUntil(line, domainCode, {' '}, pos)

  pos.inc

  pos.inc parseUntil(line, pageTitle, {' '}, pos)

  pos.inc

  pos.inc parseInt(line, result, pos)

  pos.inc

  pos.inc parseInt(line, pageSize, pos)
