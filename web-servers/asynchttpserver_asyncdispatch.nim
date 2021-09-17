# https://dev.to/xflywind/write-a-simple-web-framework-in-nim-language-from-scratch-ma0

import asynchttpserver, asyncdispatch

var server = newAsyncHttpServer()

proc cb(req: Request) {.async.} =
  await req.respond(Http200, "Hello World", newHttpHeaders())

waitFor server.serve(Port(8080), cb)
