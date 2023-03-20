import prologue
import std/[db_postgres, osproc, strformat]

let db = open("localhost", "miki", "ilMiki2014!", "nim_playground")

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

proc demo_shell*(ctx: Context) {.async.} =
  let (output, _) = execCmdEx("psql -qAtX -d diesel_demo -v id=1 -f json_agg.sql")
  resp fmt"<p>{output}</p>"

proc demo_pg*(ctx: Context) {.async.} =
  let v = db.getAllRows(sql"SELECT version();")
  resp fmt"<p>{v}</p>"

let settings = newSettings(debug = false)
let app = newApp(settings = settings)
app.addRoute("/", hello)
app.addRoute("/demo-shell", demo_shell)
app.addRoute("/demo-pg", demo_pg)
app.run()

## ## Run
## nim c -d:release --threads:on -r prologue/call_psql/app.nim
##
## ## Benchmark
## wrk -t2 -c100 -d5s http://localhost:8080/demo-pg
## Running 5s test @ http://localhost:8080/demo-pg
##   2 threads and 100 connections
##   Thread Stats   Avg      Stdev     Max   +/- Stdev
##     Latency    15.21ms    5.47ms 164.79ms   88.40%
##     Req/Sec     3.33k   599.60     4.00k    70.00%
##   33151 requests in 5.01s, 8.63MB read
## Requests/sec:   6621.68
## Transfer/sec:      1.72MB
