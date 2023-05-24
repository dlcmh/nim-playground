import std/[parseutils]

proc getTitle*(line: string, domainCode: var string, title: var string) =
  var pos = 0

  pos.inc parseUntil(line, domainCode, {' '}, pos)

  pos.inc

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
  # nim c -d:release parse_page_title_var_param.nim
  # time /tmp/nim/parse_page_title_var_param
  # 336091466
  # /tmp/nim/parse_page_title_var_param  2.16s user 0.08s system 99% cpu 2.255 total
