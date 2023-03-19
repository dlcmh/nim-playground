import prologue
import std/[osproc, strformat]

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

proc demo_exec_process*(ctx: Context) {.async.} =
  let (output, _) = execCmdEx("psql -qAtX -d diesel_demo -v id=1 -f json_agg.sql")
  resp fmt"<p>{output}</p>"

let app = newApp()
app.addRoute("/", hello)
app.addRoute("/demo-exec-process", demo_exec_process)
app.run()
