#Compile with -d:ssl to enable.
import std/httpclient
import std/monotimes
import std/os
import times
import strutils as str
import std/re

let urlRegex = re"^https?://[^\s/$.?#].[^\s]*$"

proc isValidUrl(url: string): bool =
  url.match(urlRegex)

proc ping(client: HttpClient, url: string, nRequests: int = 1, headRequest = false) =
    var averageResponseTime: int = 0
    for i in 1..nRequests:
        let start = getMonoTime()
        var resp: Response
        try:
            resp = if headRequest: client.head(url) else: client.get(url)
        except CatchableError as e:
            echo "Error: ", e.msg
            continue
        let elapsed = getMonoTime() - start
        let milli = elapsed.inMilliseconds
        echo url, " ", resp.status, " ", milli, "ms"
        averageResponseTime += milli
    echo "Average response time: ", averageResponseTime div  nRequests, "ms"


when isMainModule:
    if paramCount() < 2:
        quit "Usage: http-ping <url> <nRequests>", QuitFailure
    let url = paramStr(1)
    if not isValidUrl(url):
        quit "Invalid URL format", QuitFailure
    let client = newHttpClient()
    ping(client, url, parseInt(paramStr(2)))

