## run with:
## nim c -r nim_in_action/chat/clientMessageDisplay.nim localhost

import std/[asyncdispatch, asyncnet, os]
import protocol

proc loop(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo "Connecting to ", serverAddr, "..."
  await socket.connect(serverAddr, 7687.Port)
  echo "Connected!"
  echo "Waiting to receive messages."
  while true:
    let line = await socket.recvLine
    let parsed = parseMessage(line)
    echo parsed.username, " said ", parsed.message

echo "Chat message display app started."
if paramCount() == 0:
  quit "Please specify the server address, e.g. ./client localhost"

let serverAddr = paramStr(1)
var socket = newAsyncSocket()
waitFor loop(socket, serverAddr)
