import memfiles
import threadpool
import ../parse_wikipedia_page_views

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

# C - returned line isn't a Nim string
# 0.24s user 0.10s system 98% cpu 0.340 total
# for line in mf.memSlices:
#   totalLength += line.size

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


proc i(file: File, chunkSize = 1_000_000) =
  var totalLength = 0
  var buffer = newString(chunkSize)
  while not file.endOfFile:
    let sizeRead = file.readChars(buffer)
    totalLength += sizeRead
    buffer.setLen(1_000_000)
  echo totalLength

# echo totalLength

when isMainModule:
  # 423194
  # 420037739
  # /tmp/nim/total_length  0.54s user 0.12s system 98% cpu 0.675 total
  e(wikiFilename)

  # 10
  # 111 thequi
  # h(io.open(dataFilename))

  # 427688772
  # /tmp/nim/total_length  0.00s user 0.06s system 97% cpu 0.061 total
  i(io.open(wikiFilename))
