import mummy, mummy/routers

proc indexHandler(request: Request) =
  var headers: HttpHeaders
  headers["Content-Type"] = "text/plain"
  request.respond(200, headers, "Hello, World!")

var router: Router
router.get("/", indexHandler)

let server = newServer(router)
echo "Serving on http://localhost:8080"
server.serve Port(8080)

# iMac 2023-05-15
# Mem: approx 3MB
# wrk -t2 -c100 -d5s http://localhost:8080
# Running 5s test @ http://localhost:8080
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency     2.17ms  349.98us  21.47ms   88.77%
#     Req/Sec    22.68k   610.92    23.63k    81.00%
#   225642 requests in 5.00s, 16.14MB read
# Requests/sec:  45118.55
# Transfer/sec:      3.23MB
