import prologue, std/[asyncdispatch, httpclient]

proc indexHandler*(ctx: Context) {.async.} =
  let client = newAsyncHttpClient()
  let response = await client.get("https://jsonplaceholder.typicode.com/todos/1")

  # https://github.com/nim-lang/Nim/issues/9716#issuecomment-439218732
  client.close

  resp await response.body

let app = newApp()
app.addRoute("/", indexHandler)
app.run()

# MacBook Pro 2023-05-16:
# memory usage keeps increasing if `client.close` isn't used
# wrk -t2 -c100 -d5s http://localhost:8080
# Running 5s test @ http://localhost:8080
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency   785.80ms   94.68ms   1.08s    79.56%
#     Req/Sec    83.30     68.57   290.00     68.85%
#   597 requests in 5.03s, 125.35KB read
# Requests/sec:    118.61
# Transfer/sec:     24.90KB
