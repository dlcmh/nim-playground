var data = "Hello World"

# proc showData() {.thread.} = # must not access vars created in main thread
proc showData(data: string) {.thread.} =
  echo data

# var thread: Thread[void]
var thread: Thread[string]

# createThread[void](thread, showData)
createThread[string](thread, showData, data)
joinThread(thread)
