## page 163

import std/[parseutils]

let line = "en Nim_(programming_language) 1 70231"

var pos = 0

var domainCode = ""
pos.inc parseUntil(line, domainCode, {' '}, pos)

pos.inc

var pageTitle = ""
pos.inc parseUntil(line, pageTitle, {' '}, pos)

pos.inc

var pageViews = 0
pos.inc parseInt(line, pageViews, pos)

pos.inc

var pageSize = 0
pos.inc parseInt(line, pageSize, pos)

when isMainModule:
  import std/[unittest]

  check domainCode == "en"
  check pageTitle == "Nim_(programming_language)"
  check pageViews == 1
  check pageSize == 70231
