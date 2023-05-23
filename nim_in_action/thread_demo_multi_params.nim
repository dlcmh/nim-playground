## page 155
## because createThread can only pass one variable to the thread
## being created, a new type to hold multiple pieces of data
## must be defined in order to pass multiple separate pieces of data

type
  ThreadData = tuple
    greeting: string
    count: int

var greeting = "Hello World"

proc showData(data: ThreadData) {.thread.} =
  echo "Say '", data.greeting, "' ", data.count, " time(s)."

var thread: Thread[ThreadData]
var data: ThreadData = (greeting, 10)
createThread[ThreadData](thread, showData, data)
joinThread(thread)
