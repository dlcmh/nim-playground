import prologue
import std/[db_postgres, random, strformat]

# let db = open("localhost", "miki", "ilMiki2014!", "nim_playground")

# for better performance, leave the host blank to use Postgres socket instead of TCP
let db = open("", "dlcmh", "", "")

randomize()

proc getPgVersion*(ctx: Context) {.async.} =
  let m = rand(100)
  let n = rand(100)
  # let math = "9 * 99"
  let math = fmt"{m} * {n}"
  # let v = db.getAllRows(sql"select version()")
  let rows = db.getAllRows(sql fmt"select {math}")
  let result = rows[0][0]
  # resp fmt"<p>{v}</p>"
  resp fmt"<html><body><pre>{math} = {result}</pre></body></html>"

let settings = newSettings(debug = true)
let app = newApp(settings = settings)
app.addRoute("/", getPgVersion)
app.run()

## ## Run
## nim c -d:release --threads:on -r prologue/postgres_version.nim
##
## ## Benchmark
## wrk -t2 -c100 -d5s http://localhost:8080
## Running 5s test @ http://localhost:8080
##   2 threads and 100 connections
##   Thread Stats   Avg      Stdev     Max   +/- Stdev
##     Latency    15.21ms    5.47ms 164.79ms   88.40%
##     Req/Sec     3.33k   599.60     4.00k    70.00%
##   33151 requests in 5.01s, 8.63MB read
## Requests/sec:   6621.68
## Transfer/sec:      1.72MB
## ## CPU usage
## approx 55% & 40% for the app & postgres processes respectively
## ## Memory usage
## App starts at 5.3 MB and goes up to, and stays at 8.2 MB after benchmarking starts
