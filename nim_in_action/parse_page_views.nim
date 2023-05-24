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

when isMainModule:
  import std/[memfiles]

  proc getTotalViews(filepath: string): int =
    for line in memFiles.open(filepath).lines:
      result += line.pageViews

  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  echo filepath.getTotalViews

  # Results:
  # nim c -d:release parse_page_views.nim
  # time /tmp/nim/parse_page_views
  # 27039953
  # /tmp/nim/parse_page_views  1.12s user 0.07s system 97% cpu 1.220 total
