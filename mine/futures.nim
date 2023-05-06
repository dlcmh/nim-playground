# Nim in Action, page 84

import std/[asyncdispatch]

var future = newFuture[int]()
doAssert not future.finished

proc lol(future: Future[int]) =
  echo "Future is no longer empty, ", future.read

future.callback = lol
# On fail:
# /Users/dlcmh/projects/nim-apps/nim-playground/mine/futures.nim(32) futures
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(238) fail
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(165) call
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(104) callSoon
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(279) :anonymous
# /Users/dlcmh/projects/nim-apps/nim-playground/mine/futures.nim(9) lol
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(389) read
# Error: unhandled exception: The future failed!
# Async traceback:
# Exception message: The future failed!
#  [ValueError]
# Error: execution of an external program failed: '/tmp/nim/futures '

# future.callback =
#   proc (future: Future[int]) =
#     echo "Future is no longer empty, ", future.read
# On fail:
# /Users/dlcmh/projects/nim-apps/nim-playground/mine/futures.nim(17) futures
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(238) fail
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(165) call
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(104) callSoon
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(279) :anonymous
# /Users/dlcmh/projects/nim-apps/nim-playground/mine/futures.nim(14) :anonymous
# /Users/dlcmh/.choosenim/toolchains/nim-1.6.12/lib/pure/asyncfutures.nim(389) read
# Error: unhandled exception: The future failed!
# Async traceback:
# Exception message: The future failed!
#  [ValueError]
# Error: execution of an external program failed: '/tmp/nim/futures '

# future.complete(42) # Future is no longer empty, 42
future.fail newException(ValueError, "The future failed!")
