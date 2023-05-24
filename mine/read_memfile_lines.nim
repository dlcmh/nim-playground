import std/[memfiles]

iterator readByLine*(filename: string): string =
  var file = memfiles.open(filename)
  for line in file.lines:
    yield line
  file.close

when isMainModule:
  let filename = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  # let filename = "./data.txt"
  # var i = 0
  var length = 0
  for line in filename.readByLine:
    # if i == 1_000_000: break
    length += line.len
    # i += 1
  echo length
