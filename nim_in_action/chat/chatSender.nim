import std/[asyncdispatch, asyncnet, os, threadpool]
import protocol

proc connectSocket(socket: AsyncSocket, serverAddr: string) {.async.} =
  echo "Connecting to ", serverAddr, "..."
  await socket.connect(serverAddr, 7687.Port)
  echo "Connected!"
  echo "Start typing messages."

proc initSendMessageLoop(socket: AsyncSocket) =
  # var fv = spawn stdin.readLine
  while true:
    ## No observable difference in mem, threads, and cpu usage on
    ##   macOS Activity Monitor compared to `var fv` & `fv =` approach
    let fv = spawn stdin.readLine
    # if fv.isReady:
    #   let message = createMessage("Anonymous", ^fv)
    #   asyncCheck socket.send(message)
    #   fv = spawn stdin.readLine

    ## immediate response on pressing enter, compared to the
    ##   `if fv.isReady` version which seems to pause for 500ms
    ##   (default poll sleep duration) to coalesce & then send messages
    let message = createMessage("Anonymous", ^fv)
    asyncCheck socket.send(message)
    # fv = spawn stdin.readLine
    poll()

proc main() =
  if paramCount() == 0:
    quit "Please specify the server address, e.g. ./client localhost"
  echo "Chat application started."
  let serverAddr = paramStr(1)
  var socket = newAsyncSocket()
  waitFor connectSocket(socket, serverAddr)
  initSendMessageLoop(socket)

main()
