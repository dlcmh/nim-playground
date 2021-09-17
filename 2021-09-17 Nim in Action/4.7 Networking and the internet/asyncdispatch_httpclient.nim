import asyncdispatch
import httpclient

let client = newAsyncHttpClient()
let response = waitFor client.get("https://nim-lang.org")

echo response.version
echo response.status
echo waitFor response.body
