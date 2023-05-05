## run with:
## nim c -r nim_in_action/chat/client.nim localhost

import std/[asyncdispatch, asyncnet, os, threadpool]
import protocol

proc connect(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo "Connecting to ", serverAddr, "..."
  await socket.connect(serverAddr, 7687.Port)
  echo "Connected!"
  echo "Start typing messages."
  while true:
    let line = await socket.recvLine
    let parsed = parseMessage(line)
    echo parsed.username, " said ", parsed.message

echo "Chat application started."
if paramCount() == 0:
  quit "Please specify the server address, e.g. ./client localhost"

let serverAddr = paramStr(1)
var socket = newAsyncSocket()
asyncCheck connect(socket, serverAddr) # page 96
                                       # asyncCheck discards the future safely
                                       # code runs in the background as neither
                                       # await nor waitFor is used

var messageFlowVar = spawn stdin.readLine
while true:
  if messageFlowVar.isReady:
    let message = createMessage("Anonymous", ^messageFlowVar)
    asyncCheck socket.send(message)
    messageFlowVar = spawn stdin.readLine
  poll()
