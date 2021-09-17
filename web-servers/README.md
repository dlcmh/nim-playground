Highest performance is with [httpbeast](https://github.com/dom96/httpbeast):

```
wrk -t4 -c100 -d10s --latency http://localhost:8080/

Running 10s test @ http://localhost:8080/
  4 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.06ms  581.60us  31.76ms   94.47%
    Req/Sec    12.28k     2.04k   47.99k    96.51%
  Latency Distribution
     50%    1.94ms
     75%    2.11ms
     90%    2.32ms
     99%    3.54ms
  490147 requests in 10.10s, 49.55MB read
Requests/sec:  48532.44
Transfer/sec:      4.91MB
```
