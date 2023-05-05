## run with:
## nim c -r nim_in_action/chat/chatClient.nim localhost

import std/[asyncdispatch, asyncnet, os, threadpool]
import protocol

proc connectSocket(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo "Connecting to ", serverAddr, "..."
  await socket.connect(serverAddr, 7687.Port)
  echo "Connected!"

proc listenForMessages(connectedSocket: AsyncSocket) {.async.} =
  echo "Listening for messages."
  while true:
    let line = await connectedSocket.recvLine
    let parsed = parseMessage(line)
    echo parsed.username, " said ", parsed.message

proc initMessageSendingLoop(socket: AsyncSocket) =
  while true:
    let fv = spawn stdin.readLine
    let message = createMessage("Anonymous", ^fv)
    asyncCheck socket.send(message)
    # poll()

proc main() =
  if paramCount() == 0:
    quit "Please specify the server address, e.g. ./client localhost"
  echo "Chat application started."
  let serverAddr = paramStr(1)
  var socket = newAsyncSocket()
  waitFor connectSocket(socket, serverAddr)
  asyncCheck listenForMessages(socket)
  # initMessageSendingLoop(socket)
  var fv = spawn stdin.readLine
  while true:
    if fv.isReady:
      let message = createMessage("Anonymous", ^fv)
      asyncCheck socket.send(message)
      fv = spawn stdin.readLine
      echo "respawned"
    poll()

main()
