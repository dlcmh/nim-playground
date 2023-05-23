import std/[memfiles]
import parse_with_parseutils

proc pageViews(filepath: string): int =
  for line in memFiles.open(filepath).lines:
  # for line in filepath.lines:
    let (_, _, views, _) = line.parsed
    result += views

when isMainModule:
  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  echo pageViews(filepath)

# for line in memFiles.open(filepath).lines:
# 27039953
# /tmp/nim/parse_wikipedia  5.14s user 0.20s system 85% cpu 6.241 total

# for line in filepath.lines:
# 27039953
# /tmp/nim/parse_wikipedia  7.05s user 0.16s system 93% cpu 7.713 total
