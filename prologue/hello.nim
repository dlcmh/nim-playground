import prologue, std/[asyncdispatch]

proc indexHandler*(ctx: Context) {.async.} =
  resp "hello"

let app = newApp()
app.addRoute("/", indexHandler)
app.run()

# MacBook Pro 2023-05-16:
# wrk -t2 -c100 -d5s http://localhost:8080
# Running 5s test @ http://localhost:8080
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency     5.49ms    4.55ms 121.23ms   99.13%
#     Req/Sec     9.64k   840.34    10.42k    87.00%
#   95908 requests in 5.01s, 12.44MB read
# Requests/sec:  19159.26
# Transfer/sec:      2.48MB
