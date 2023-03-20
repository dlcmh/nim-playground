import prologue
import std/[osproc, strformat]

# shell output
proc demo_shell*(ctx: Context) {.async.} =
  let (output, _) = execCmdEx("ls -al")
  resp fmt"<p>{output}</p>"

let settings = newSettings(debug = true)
let app = newApp(settings = settings)
app.addRoute("/", demo_shell)
app.run()
