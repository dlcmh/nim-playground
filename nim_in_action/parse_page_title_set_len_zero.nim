import std/[parseutils]

proc getTitle*(line: string, domainCode: var string, title: var string) =
  var pos = 0

  # page 165
  # improves performance
  domainCode.setLen(0)
  pos.inc parseUntil(line, domainCode, {' '}, pos)

  pos.inc

  # page 165
  # improves performance
  title.setLen(0)
  pos.inc parseUntil(line, title, {' '}, pos)

  pos.inc

  # pageViews
  pos.inc skipUntil(line, ' ', pos)

  pos.inc

  # pageSize
  pos.inc skipUntil(line, ' ', pos)

when isMainModule:
  import std/[memfiles]

  proc getTotalLengthOfTitles(filepath: string): int =
    var domainCode: string
    var title: string
    for line in memFiles.open(filepath).lines:
      line.getTitle(domainCode, title)
      result += title.len

  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  echo filepath.getTotalLengthOfTitles

  # Results:
  # nim c -d:release parse_page_title_set_len_zero.nim
  # time /tmp/nim/parse_page_title_set_len_zero
  # 336091466
  # /tmp/nim/parse_page_title_set_len_zero  1.92s user 0.07s system 99% cpu 2.001 total
