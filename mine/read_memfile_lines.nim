import std/[memfiles]
import parse_wikipedia_page_views

iterator readByLine*(filename: string): string =
  var file = memfiles.open(filename)
  for line in file.lines:
    yield line
  file.close

when isMainModule:
  proc getTitleLength(line: string): int =
    var domainCode: string
    var pageTitle: string
    var pageViews: int
    var pageSize: int
    line.parseInto(domainCode, pageTitle, pageViews, pageSize)
    result = pageTitle.len

  let filename = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  # let filename = "./data.txt"
  var i = 0
  var length = 0
  for line in filename.readByLine:
    if i == 100: break
    # var domainCode: string
    # var pageTitle: string
    # var pageViews: int
    # var pageSize: int
    # line.parseInto(domainCode, pageTitle, pageViews, pageSize)
    length += line.getTitleLength
    i += 1
  echo length

# time /tmp/nim/read_memfile_lines
# 336091466
# /tmp/nim/read_memfile_lines  4.86s user 0.12s system 90% cpu 5.531 total
