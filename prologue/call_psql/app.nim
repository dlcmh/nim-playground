import prologue
import std/[db_postgres, osproc, strformat]

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

proc demo_shell*(ctx: Context) {.async.} =
  let (output, _) = execCmdEx("psql -qAtX -d diesel_demo -v id=1 -f json_agg.sql")
  resp fmt"<p>{output}</p>"

proc demo_pg*(ctx: Context) {.async.} =
  let db = open("localhost", "miki", "ilMiki2014!", "nim_playground")
  let v = db.getAllRows(sql"SELECT version();")
  resp fmt"<p>{v}</p>"

let app = newApp()
app.addRoute("/", hello)
app.addRoute("/demo-shell", demo_shell)
app.addRoute("/demo-pg", demo_pg)
app.run()
