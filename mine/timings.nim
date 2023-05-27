# https://nim-lang.org/blog/2021/07/28/Nim-Efficient-Expressive-Elegant-Benchmarking.html

import std/[monotimes, times]

# https://nim-lang.org/docs/monotimes.html
# The std/monotimes module implements monotonic timestamps. A monotonic timestamp represents the time that has passed since some system defined point in time. The monotonic timestamps are guaranteed not to decrease, meaning that that the following is guaranteed to work:
let a = getMonoTime()
let b = getMonoTime()
assert a <= b

echo a # 132346851719944
echo b # 132346851719944s

let elapsed = b - a
echo elapsed.inMilliseconds # 0
echo elapsed.inMicroseconds # 0
echo elapsed.inNanoseconds # 287
