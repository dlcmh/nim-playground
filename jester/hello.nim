import jester

routes:
  get "/":
    resp "Hello world"

# iMac 2023-05-16:
# wrk -t2 -c100 -d5s http://localhost:5000
# Running 5s test @ http://localhost:5000
#   2 threads and 100 connections
#   Thread Stats   Avg      Stdev     Max   +/- Stdev
#     Latency     1.20ms  233.99us  18.24ms   96.38%
#     Req/Sec    41.71k     1.31k   42.89k    87.00%
#   414885 requests in 5.00s, 57.37MB read
# Requests/sec:  82964.77
# Transfer/sec:     11.47MB
