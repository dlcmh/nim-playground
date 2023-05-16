## https://github.com/guzba/mummy/blob/f6d88da9505d24139a112014b2e5e5bc06adb17f/tests/test_http.nim#L2
## alternative to async http requests re: Nim in Action page 126

import mummy, mummy/routers, std/[httpclient]

proc indexHandler(request: Request) =
  var headers: mummy.HttpHeaders
  headers["Content-Type"] = "text/html"
  let client = newHttpClient()
  # let content = client.getContent("http://nim-lang.org")
  let content = client.getContent("https://jsonplaceholder.typicode.com/todos/1")
  # request.respond(200, headers, "<h1>lol</h1>")

  # https://github.com/nim-lang/Nim/issues/9716#issuecomment-439218732
  client.close

  request.respond(200, headers, content)

var router: Router
router.get("/", indexHandler)

let server = newServer(router)
echo "Serving on http://localhost:8080"
server.serve Port(8080)

# MacBook Pro 2023-05-16:
# memory ussage keeps going up after every wrk run unless `client.close` is used
# wrk -t2 -c100 -d5s http://localhost:8080
# Running 5s test @ http://localhost:8080
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency     1.46s   286.01ms   1.97s    79.79%
#     Req/Sec    41.60     32.07   121.00     71.15%
#   293 requests in 5.05s, 41.20KB read
#   Socket errors: connect 0, read 0, write 0, timeout 1
# Requests/sec:     58.06
# Transfer/sec:      8.16KB
