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

when isMainModule:
  import std/[memfiles]

  proc getTotalLengthOfTitles(filepath: string): int =
    for line in memFiles.open(filepath).lines:
      result += line.getDomainAndTitle.pageTitle.len

  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  echo filepath.getTotalLengthOfTitles

  # Results:
  # nim c -d:release parse_page_title.nim
  # time /tmp/nim/parse_page_title
  # 336091466
  # /tmp/nim/parse_page_title  2.19s user 0.08s system 99% cpu 2.286 total
