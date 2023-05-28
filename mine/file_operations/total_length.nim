import memfiles
import threadpool
import ../parse_wikipedia_page_views
import ../parse_wiki

const dataFilename = "./data"
const wikiFilename = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"

# let mf = memfiles.open(filename)


# A
# 1.08s user 0.12s system 97% cpu 1.231 total
# for line in mf.lines:
#   totalLength += line.len

# B - faster than A
# binary 111K, 0.76s user 0.10s system 98% cpu 0.881 total
# when compiled with --mm:arc:
# binary 73k, 0.43s user 0.11s system 98% cpu 0.541 total
# var buffer: string
# for line in mf.lines(buffer):
#   totalLength += line.len

proc showLineCount(filename: string) =
  let file = memfiles.open(filename)
  var lineCount = 0
  for _ in file.memSlices:
    lineCount.inc
  echo lineCount

# D (based on B)
# without startAt:
# 336091466
# /tmp/nim/total_length  2.35s user 0.11s system 98% cpu 2.487 total
# iMac /tmp/nim/total_length  1.75s user 0.08s system 99% cpu 1.833 total
# with startAt V 7_100_000:
# 2750344
# /tmp/nim/total_length  0.44s user 0.10s system 97% cpu 0.557 total
# var buffer: string
# var startAt = 0
# var domainCode: string
# var pageTitle: string
# var pageViews: int
# var pageSize: int
# for line in mf.lines(buffer):
  # if startAt < 3_100_000:
  #   startAt.inc
  #   continue
  # line.parseInto(domainCode, pageTitle, pageViews, pageSize)
  # totalLength += pageTitle.len

proc e(filename: string) =
  let mf = memfiles.open(filename)
  var totalLength = 0
  var buffer: string
  var i = 0
  var chunkAt = 10_000
  var didShowBufferLength = false
  for line in mf.lines:
    if (i + 1) mod chunkAt == 0:
      if not didShowBufferLength:
        echo buffer.len
        didShowBufferLength = true
      totalLength += buffer.len
      buffer.setLen(0)
    buffer.add line
    i += 1
  echo totalLength

# F
# 420037739
# binary size 94K, /tmp/nim/total_length  0.50s user 0.10s system 99% cpu 0.601 total
# var buffer: string
# var i = 0
# var chunkAt = 10_000
# var responses: seq[FlowVar[int]]
# proc getLength(content: string): int =
#   content.len
# for line in mf.lines:
#   if (i + 1) mod chunkAt == 0:
#     responses.add spawn getLength(buffer)
#     buffer.setLen(0)
#   buffer.add line
#   i += 1
# for response in responses:
#   totalLength += ^response

# G
# 336091466
# iMac /tmp/nim/total_length  3.24s user 1.02s system 198% cpu 2.147 total
# var i = 0
# var chunkAt = 1000 # trial & error, at 1000 mem usage spikes to < 2MB on iMac
# var chunk = newSeq[string](chunkAt)
# var responses: seq[FlowVar[int]]
# proc getLength(chunk: seq[string]): int =
#   var domainCode: string
#   var pageTitle: string
#   var pageViews: int
#   var pageSize: int
#   for line in chunk:
#     line.parseInto(domainCode, pageTitle, pageViews, pageSize)
#     result += pageTitle.len
# for line in mf.lines:
#   if (i + 1) mod chunkAt == 0:
#     responses.add spawn getLength(chunk)
#     chunk.setLen(0)
#   chunk.add line
#   i += 1
# if chunk.len > 0:
#   responses.add spawn getLength(chunk)
# for response in responses:
#   totalLength += ^response

proc h(file: File, chunkSize = 10) =
  var buffer = newString(chunkSize)
  let sizeRead = file.readChars(buffer)
  echo sizeRead, "\n", buffer


proc showFileSize(filename: string, chunkSize = 1_000_000) =
  let file = io.open(filename)
  var totalLength = 0
  var buffer = newString(chunkSize)
  while not file.endOfFile:
    let sizeRead = file.readChars(buffer)
    totalLength += sizeRead
    buffer.setLen(1_000_000)
  echo totalLength

proc showTotalRecords(filename: string, chunkSize = 1_000_000) =
  let file = io.open(filename)
  var count = 0
  var buffer = newString(chunkSize)
  while not file.endOfFile:
    let sizeRead = file.readChars(buffer)
    for v in buffer:
      if v == '\n':
        count.inc
    buffer.setLen(sizeRead)
  echo count

proc showTotalTitleLength1(filename: string, chunkSize = 1_000_000) =
  let file = io.open(filename)
  var buffer = newString(chunkSize)
  var totalLength = 0
  while not file.endOfFile:
    var lineStart = 0
    var lineFeedPos = 0
    let sizeRead = file.readChars(buffer)
    for i, v in buffer:
      if v == '\n':
        lineFeedPos = i
        if lineFeedPos > lineStart:
          let fields = parsed(buffer[lineStart..<lineFeedPos])
          totalLength += fields.pageTitle.len
          lineStart = lineFeedPos + 1
    file.setFilePos(lineFeedPos - buffer.high, fspCur)
    buffer.setLen(sizeRead)
  echo totalLength

proc showTotalTitleLength2(filename: string, chunkSize = 1_000_000) =
  let file = io.open(filename)
  var buffer = newString(chunkSize)
  var totalLength = 0
  var domainCode: string
  var pageTitle: string
  var pageViews: int
  var pageSize: int
  var limit = 0
  while not file.endOfFile and limit != 3:
    var lineStart = 0
    var lineFeedPos = 0
    let sizeRead = file.readChars(buffer)
    for i, v in buffer:
      if limit == 3: break
      if v == '\n':
        lineFeedPos = i
        if lineFeedPos > lineStart:
          buffer[lineStart..<lineFeedPos].parseInto(domainCode, pageTitle,
              pageViews, pageSize)
          echo domainCode, "|", pageViews, "|", pageTitle.len
          totalLength += pageTitle.len
          lineStart = lineFeedPos + 1
          limit.inc
    file.setFilePos(lineFeedPos - buffer.high, fspCur)
    buffer.setLen(sizeRead)
  echo totalLength

proc showTotalTitleLength3(filename: string) =
  let file = memfiles.open(filename)
  var totalLength = 0
  var domainCode: string
  var pageTitle: string
  var pageViews: int
  var pageSize: int
  for line in file.lines:
    line.parseInto(domainCode, pageTitle, pageViews, pageSize)
    totalLength += pageTitle.len
  echo totalLength

proc spawnShowTotalTitleLength3(n = 2, filename = wikiFilename) =
  for _ in 1 .. n:
    spawn showTotalTitleLength3(filename)
  sync()

proc getTotalTitleLengthForLinesLt(filename: string, n: int) =
  let file = memfiles.open(filename)
  var totalLength = 0
  var domainCode: string
  var pageTitle: string
  var pageViews: int
  var pageSize: int
  var i = 0
  for line in file.lines:
    if i < n:
      line.parseInto(domainCode, pageTitle, pageViews, pageSize)
      totalLength += pageTitle.len
      i.inc
    else:
      break
  echo totalLength

proc getTotalTitleLengthForLinesGte(filename: string, n: int) =
  let file = memfiles.open(filename)
  var totalLength = 0
  var domainCode: string
  var pageTitle: string
  var pageViews: int
  var pageSize: int
  var i = 0
  for line in file.lines:
    if i >= n:
      line.parseInto(domainCode, pageTitle, pageViews, pageSize)
      totalLength += pageTitle.len
    else:
      i.inc
  echo totalLength

when isMainModule:
  import std/[monotimes, strutils, times]

  let startTime = getMonoTime()

  # 7156099
  # /tmp/nim/total_length  0.23s user 0.11s system 98% cpu 0.340 total
  # showLineCount(wikiFilename)

  # 423194
  # 420037739
  # /tmp/nim/total_length  0.54s user 0.12s system 98% cpu 0.675 total
  # e(wikiFilename)

  # 10
  # 111 thequi
  # h(io.open(dataFilename))

  # 427688772
  # /tmp/nim/total_length  0.00s user 0.06s system 97% cpu 0.061 total
  # showFileSize(wikiFilename)

  # 200
  # /tmp/nim/total_length  0.01s user 0.00s system 75% cpu 0.013 total
  # showTotalRecords(dataFilename)

  # 336879189
  # /tmp/nim/total_length  5.81s user 0.10s system 90% cpu 5.913 total
  # showTotalTitleLength1(wikiFilename)

  # 336879189
  # /tmp/nim/total_length  4.43s user 0.08s system 99% cpu 4.521 total
  # showTotalTitleLength2(wikiFilename)

  # 336091466
  # /tmp/nim/total_length  2.41s user 0.14s system 97% cpu 2.610 total
  # showTotalTitleLength3(wikiFilename)

  # 336091466
  # mem: 516KiB, dur: 2468ms
  # /tmp/nim/total_length  2.31s user 0.12s system 97% cpu 2.490 total
  # spawnShowTotalTitleLength3(1)

  # 336091466
  # 336091466
  # mem: 516KiB, dur: 2675ms
  # /tmp/nim/total_length  4.98s user 0.28s system 192% cpu 2.733 total
  # spawnShowTotalTitleLength3()

  # 336091466
  # 336091466
  # 336091466
  # mem: 516KiB, dur: 3716ms
  # /tmp/nim/total_length  10.30s user 0.52s system 284% cpu 3.806 total
  # spawnShowTotalTitleLength3(3)

  # 336091466
  # 336091466
  # 336091466
  # 336091466
  # mem: 516KiB, dur: 4653ms
  # /tmp/nim/total_length  16.68s user 0.76s system 363% cpu 4.795 total
  # spawnShowTotalTitleLength3(4)

  # 336091466
  # 336091466
  # 336091466
  # 336091466
  # 336091466
  # mem: 516KiB, dur: 7709ms
  # /tmp/nim/total_length  20.73s user 0.96s system 274% cpu 7.892 total
  # spawnShowTotalTitleLength3(5)

  # trial and error - getTotalTitleLengthForLinesLt to process 5/7 of the lines
  # MacBook Pro
  # 182052736
  # 154038730
  # mem: 516KiB, dur: 1562ms
  # /tmp/nim/total_length  2.71s user 0.18s system 182% cpu 1.584 total
  # iMac
  # 182052736
  # 154038730
  # mem: 516KiB, dur: 1143ms
  # /tmp/nim/total_length  2.04s user 0.12s system 185% cpu 1.163 total
  spawn wikiFilename.getTotalTitleLengthForLinesLt 5_000_000
  spawn wikiFilename.getTotalTitleLengthForLinesGte 5_000_000

  # iMac
  # 182052736
  # 182052736
  # 154038730
  # 154038730
  # mem: 516KiB, dur: 1340ms
  # /tmp/nim/total_length  4.22s user 0.32s system 322% cpu 1.406 total
  # spawn wikiFilename.getTotalTitleLengthForLinesLt 5_000_000
  # spawn wikiFilename.getTotalTitleLengthForLinesGte 5_000_000
  # spawn wikiFilename.getTotalTitleLengthForLinesLt 5_000_000
  # spawn wikiFilename.getTotalTitleLengthForLinesGte 5_000_000
  sync()

  echo "mem: ", getTotalMem().formatSize, ", ", "dur: ", (getMonoTime() -
      startTime).inMilliseconds, "ms"
