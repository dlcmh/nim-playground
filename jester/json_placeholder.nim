import jester, std/[httpclient]

routes:
  get "/":
    let client = newAsyncHttpClient()
    let response = await client.get("https://jsonplaceholder.typicode.com/todos/1")
    let body = await response.body

    # https://github.com/nim-lang/Nim/issues/9716#issuecomment-439218732
    client.close

    resp body

# iMac 2023-05-16:
# memory usage keeps increasing if `client.close` isn't used
# wrk -t2 -c100 -d5s http://localhost:5000
# Running 5s test @ http://localhost:5000
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency   674.19ms   75.19ms 950.99ms   85.29%
#     Req/Sec    95.84     78.82   346.00     70.31%
#   700 requests in 5.03s, 148.34KB read
# Requests/sec:    139.22
# Transfer/sec:     29.50KB
