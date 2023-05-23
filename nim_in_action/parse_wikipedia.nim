import std/[memfiles, uri]
import parse_page_title
import parse_page_views
# import parse_with_parseutils

proc getTotalViews(filepath: string): int =
  for line in memFiles.open(filepath).lines:
  # for line in filepath.lines:
    # let (_, _, views, _) = line.parsed
    # result += views
    result += line.pageViews

proc echoTitles(filepath: string) =
  # for line in memFiles.open(filepath).lines:
  for line in filepath.lines:
    let result = line.getDomainAndTitle
    if result.domainCode != "en":
      continue
    echo result.pageTitle.decodeUrl

when isMainModule:
  const filepath = "/Users/dlcmh/Downloads/pagecounts-20160101-050000"
  # echo filepath.getTotalViews
  filepath.echoTitles

# for line in memFiles.open(filepath).lines:
# 27039953
# /tmp/nim/parse_wikipedia  5.14s user 0.20s system 85% cpu 6.241 total

# for line in filepath.lines:
# 27039953
# /tmp/nim/parse_wikipedia  7.05s user 0.16s system 93% cpu 7.713 total

# result += line.pageViews
# 27039953
# /tmp/nim/parse_wikipedia  2.80s user 0.69s system 53% cpu 6.472 total
