import std/[parseutils]

proc getDomainAndTitle*(line: string): tuple[domainCode: string,
    pageTitle: string] =
  var pos = 0

  pos.inc parseUntil(line, result.domainCode, {' '}, pos)

  pos.inc

  pos.inc parseUntil(line, result.pageTitle, {' '}, pos)

  pos.inc

  # pageViews
  pos.inc skipUntil(line, ' ', pos)

  pos.inc

  # pageSize
  pos.inc skipUntil(line, ' ', pos)
