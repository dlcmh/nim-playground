# page 80

# Imports the asyncdispatch and asyncnet modules,
# which contain the procedures and types needed to use asynchronous sockets
import std/[asyncdispatch, asyncnet]

type
  Client = ref object
    socket: AsyncSocket # the socket belonging to the client; the
                        # AsyncSocket type is an asynchronous socket
    netAddr: string     # the address from which this client has connected
    id: int
    connected: bool
  Server = ref object
    socket: AsyncSocket # socket for accepting new client connections
    clients: seq[Client]

## Defining Client and Server as reference types
## allows procedures that take these types as arguments to modify them.
## This will be essential, because new elements will need to be added to
## the clients field when new clients connect.

## Conventions for naming constructor procedures:
## MyType = object - initMyType
## MyTypeRef = ref object - newMyTypeRef
## MyTuple = tuple[x, y: int] - initMyTuple

proc newServer: Server = Server(socket: newAsyncSocket())

proc `$`(client: Client): string =
  $client.id & "(" & client.netAddr & ")"

var server = newServer()

proc processMessages(server: Server, client: Client) {.async.} =
  while true:
    let line = await client.socket.recvLine
    if line.len == 0: # Most procedures that read data from
                      # a socket may return an empty string,
                      # which signifies that the socket has
                      # disconnected from the server.
      client.connected = false
      client.socket.close
      echo client, " disconnected"
      return
    echo client, " sent: ", line
    for c in server.clients:
      if c.id != client.id and c.connected:
        await c.socket.send(line & "\c\l")

## if "Address in use", run lsof -i tcp:7687
proc loop(server: Server, port = 7687) {.async.} =
  server.socket.bindAddr(port.Port)
  server.socket.listen
  echo "Server started."
  while true:
    # let clientSocket = await server.socket.accept
    let (netAddr, clientSocket) = await server.socket.acceptAddr
    echo "Accepted connection from ", netAddr # eg 127.0.0.1
    let client = Client(
      socket: clientSocket,
      netAddr: netAddr,
      id: server.clients.len,
      connected: true
    )
    server.clients.add client
    echo server.clients
    asyncCheck processMessages(server, client)

waitFor loop(server)

## To test the connection, use nc instead of telnet:
## nc localhost 7687 -> Accepted connection!
