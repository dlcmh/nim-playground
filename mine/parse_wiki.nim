import std/[parseutils]

proc parsed*(line: string): tuple[domainCode: string, pageTitle: string,
    pageViews: int, pageSize: int] =
  var pos = 0

  pos.inc parseUntil(line, result.domainCode, {' '}, pos)

  pos.inc

  pos.inc parseUntil(line, result.pageTitle, {' '}, pos)

  pos.inc

  pos.inc parseInt(line, result.pageViews, pos)

  pos.inc

  pos.inc parseInt(line, result.pageSize, pos)

when isMainModule:
  import std/[unittest]

  let (domainCode, pageTitle, pageViews,
    pageSize) = "en Nim_(programming_language) 1 70231".parsed

  check domainCode == "en"
  check pageTitle == "Nim_(programming_language)"
  check pageViews == 1
  check pageSize == 70231
