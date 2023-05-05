import std/[os, threadpool]

# page 64: validate param count to avoid IndexError
if paramCount() == 0:
  quit "Please specify the server address, e.g. ./client localhost"

# page 64: use the following instead of paramStr(0)
# echo getAppFilename() # eg /private/tmp/nim/client

echo "Chat application started."
let serverAddr = paramStr(1)
echo "Connecting to ", serverAddr
echo "Connected."
echo "Start typing messages."

while true:
  # page 68: spawns a new thread and executes readLine there
  # message is of generic type FlowVar[T] - T in this case is string
  # --threads:on flag required for compilation,
  #   or just specify the flag in client.nims (nims is NimScript)
  let message = spawn stdin.readLine

  # page 68: ^ operator explicitly reads value from FlowVar[T] object
  # ^message blocks the main thread too
  echo "Sending \"", ^message, "\""
