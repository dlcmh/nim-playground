import std/[parseutils]

proc parsed*(line: string, domainCode: var string, pageTitle: var string,
    pageViews: var int, pageSize: var int) =
  var pos = 0

  domainCode.setLen(0)
  pos.inc parseUntil(line, domainCode, {' '}, pos)

  pos.inc

  pageTitle.setLen(0)
  pos.inc parseUntil(line, pageTitle, {' '}, pos)

  pos.inc

  pageViews = 0
  pos.inc parseInt(line, pageViews, pos)

  pos.inc

  pageSize = 0
  pos.inc parseInt(line, pageSize, pos)

when isMainModule:
  import std/[unittest]

  var domainCode: string
  var pageTitle: string
  var pageViews: int
  var pageSize: int
  "en Nim_(programming_language) 1 70231".parsed(domainCode, pageTitle,
      pageViews, pageSize)

  check domainCode == "en"
  check pageTitle == "Nim_(programming_language)"
  check pageViews == 1
  check pageSize == 70231
