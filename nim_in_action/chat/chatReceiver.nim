import std/[asyncdispatch, asyncnet, os]
import protocol

proc connectSocket(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo "Connecting to ", serverAddr, "..."
  await socket.connect(serverAddr, 7687.Port)
  echo "Connected!"

proc listen(connectedSocket: AsyncSocket) {.async.} =
  echo "Listening for messages."
  while true:
    let line = await connectedSocket.recvLine
    let parsed = parseMessage(line)
    echo parsed.username, " said ", parsed.message

proc main() =
  if paramCount() == 0:
    quit "Please specify the server address, e.g. ./client localhost"
  echo "Chat application started."
  let serverAddr = paramStr(1)
  var socket = newAsyncSocket()
  waitFor connectSocket(socket, serverAddr)
  asyncCheck listen(socket)
  while true:
    ## polls and then blocks until the earlier of:
    ## - message received, or
    ## - 10 seconds later
    poll(10_000)
    echo "polled!"

main()
