# page 118

import std/[os]

echo "/a/b/c".splitPath # (head: "/a/b", tail: "c")
echo "a/b/c".splitPath # (head: "a/b", tail: "c")
echo "/a/b/c".tailDir # a/b/c
echo "a/b/c".tailDir # b/c
echo "/a/b/c/d.txt".splitFile # (dir: "/a/b/c", name: "d", ext: ".txt")

# (dir: "/a/b/c", name: "d.some", ext: ".pdf")
echo "/a/b/c/d.some.pdf".splitFile

echo "a/b/c/d.txt".splitFile # (dir: "a/b/c", name: "d", ext: ".txt")

# ---
# pcFile
# /Users/dlcmh/.viminfo
# ===
# ---
# pcDir
# /Users/dlcmh/.zsh_sessions
# ===
## other kinds:
## pcLinkToFile, pcLinkToDir
for kind, path in getHomeDir().walkDir:
  echo "---"
  echo kind
  echo path
  echo "==="
