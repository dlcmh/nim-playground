proc lineCount(): int =
  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  for _ in filepath.lines:
    result.inc

when isMainModule:
  echo lineCount()

# time /tmp/nim/lines_of_file
# 7156099
# /tmp/nim/lines_of_file  2.19s user 0.12s system 99% cpu 2.325 total
