import std/net
import std/os
import std/strutils
import std/posix

proc isPortInUse(port: Port): bool =
  try:
    var socket = newSocket(
    Domain.AF_INET,
    SockType.SOCK_STREAM,
    Protocol.IPPROTO_TCP
    )
    defer: socket.close()

    socket.bindAddr(port, "127.0.0.1")
    result = false
  except OSError as e:
    if e.errorCode == EADDRINUSE:
      result = true
    else:
      raise
  except:
    result = true

when isMainModule:
  if paramCount() == 0:
    quit "Usage: isPortInUse <port> [port...]", QuitFailure

  var ports: seq[Port] = @[]

  for i in 1 .. paramCount():
    ports.add Port(parseInt(paramStr(i)))

  for p in ports:
    echo p, ": ", if isPortInUse(p): "in use" else: " free"
