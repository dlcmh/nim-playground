# https://forum.nim-lang.org/t/3261

import std/[memfiles]

proc lineCount(): int =
  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  for _ in memSlices(memFiles.open(filepath)):
    result.inc

when isMainModule:
  echo lineCount()

# time /tmp/nim/linecount_of_file_with_memslices
# 7156099
# /tmp/nim/linecount_of_file_with_memslices  0.23s user 0.10s system 97% cpu 0.338 total
