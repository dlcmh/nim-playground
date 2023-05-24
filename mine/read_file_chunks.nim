iterator readInChunks*(filename: string, bytes: int = 5): tuple[bytesRead: int,
    chunkRead: string] =
  let file = filename.open
  var chunkRead = newString(bytes)
  while not file.endOfFile:
    let bytesRead = file.readChars(chunkRead)
    yield (bytesRead, chunkRead)
  file.close

when isMainModule:
  # let filename = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  let filename = "./data.txt"
  for (bytesRead, chunkRead) in filename.readInChunks:
    echo bytesRead, " - ", chunkRead

  # Result:
  # nim c -r data.nim
  # 5 - one
  # t
  # 5 - wo
  # th
  # 5 - ree
  # f
  # 5 - our
  # f
  # 4 - ive
  # f
