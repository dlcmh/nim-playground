## page 120

import std/[osproc]

when defined windows:
  let (ver, _) = execCmdEx "cmd /C ver"
else:
  let (ver, _) = execCmdEx "uname -sr"

echo "Operating system is ", ver # Operating system is Darwin 22.4.0
