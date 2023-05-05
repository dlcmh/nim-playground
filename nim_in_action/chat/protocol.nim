import std/[json]

type
  Message* = object
    username*: string
    message*: string

proc parseMessage*(data: string): Message =
  let dataJson = parseJson(data) # dataJson is of type JsonNode
  result.username = dataJson["username"].getStr
  result.message = dataJson["message"].getStr

proc createMessage*(username, message: string): string =
  # % converts data into appropriate JsonNodes
  # $ converts JsonNode into string
  # \c\l message separator sequence is suported by Nim's networking modules
  result = $(%{
    "username": %username,
    "message": %message
  }) & "\c\l"

when isMainModule:
  block:
    let data = """{"username": "John", "message": "Hi!"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "John"
    doAssert parsed.message == "Hi!"

  # block:
  #   let data = """foobar"""
  #   try:
  #     let _ = parseMessage(data)

  #     # page 78: parseMessage will raise exception, so
  #     #   this line should never execute
  #     doAssert false
  #   except JsonParsingError:
  #     doAssert true
  #   except CatchableError:
  #     doAssert false
  block:
    let data = """foobar"""
    doAssertRaises JsonParsingError:
      let _ = parseMessage(data)

  block:
    let expected = """{"username":"dom","message":"hello"}""" & "\c\l"
    doAssert createMessage("dom", "hello") == expected

  echo "All tests passed!"
