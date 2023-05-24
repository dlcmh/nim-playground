import std/[memfiles, threadpool]
import parse_wikipedia_page_views

iterator readByLine*(filename: string): string =
  var file = memfiles.open(filename)
  for line in file.lines:
    yield line
  yield "finished"
  file.close

when isMainModule:
  proc getTitleLength(line: string): int =
    var domainCode: string
    var pageTitle: string
    var pageViews: int
    var pageSize: int
    line.parseInto(domainCode, pageTitle, pageViews, pageSize)
    result = pageTitle.len

  proc getTotalTitleLengthPerChunk(chunk: seq[string]): int =
    for line in chunk:
      result += line.getTitleLength

  let filename = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  var length = 0
  var responses = newSeq[FlowVar[int]]()
  # var limit = 0
  var chunkLines = 100_000
  var i = 0
  var chunk = newSeq[string](chunkLines)
  for line in filename.readByLine:
    if line == "finished" or i == 11_000_000:
      if i > 0:
        responses.add spawn(chunk.getTotalTitleLengthPerChunk)
      break
    else:
      if (i + 1) mod chunkLines != 0:
        chunk.add line
      else:
        responses.add spawn(chunk.getTotalTitleLengthPerChunk)
        chunk.setLen(0)
      i.inc

    # if limit == 10: break
    # responses.add spawn(line.getTitleLength)
    # limit.inc
  for response in responses:
    length += ^response
  echo responses.len
  echo length

# time /tmp/nim/read_memfile_lines
# 336091466
# /tmp/nim/read_memfile_lines  4.86s user 0.12s system 90% cpu 5.531 total
