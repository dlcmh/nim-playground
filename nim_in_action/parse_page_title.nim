import std/[parseutils]

var pageViews = 0
var pageSize = 0

proc getDomainAndTitle*(line: string): tuple[domainCode: string,
    pageTitle: string] =
  var pos = 0

  pos.inc parseUntil(line, result.domainCode, {' '}, pos)

  pos.inc

  pos.inc parseUntil(line, result.pageTitle, {' '}, pos)

  pos.inc

  pos.inc parseInt(line, pageViews, pos)

  pos.inc

  pos.inc parseInt(line, pageSize, pos)
