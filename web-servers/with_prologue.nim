# https://github.com/planety/prologue

import prologue

# https://planety.github.io/prologue/faq/
let
  # debug attributes must be false
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = false,
                         port = Port(env.getOrDefault("port", 8080)),
                         secretKey = env.getOrDefault("secretKey", "someSecretKey")
  )

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

let app = newApp(settings = settings)
app.get("/", hello)
app.run()
