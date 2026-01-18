import std/net
import std/ssl
import std/times
import std/os

proc checkCert(host: string, port = 443, warnDays = 14) =
  echo "Running on ", now().format("yyyy-MM-dd HH:mm:ss")

  let ctx = newContext(verifyMode = CVerifyPeer)

  let socket = newSocket()
  socket.connect(host, Port(port))

  let sslSock = ctx.wrapSocket(socket)
  sslSock.setHostname(host)   # SNI
  sslSock.doHandshake()

  let cert = sslSock.getPeerCertificate()
  if cert.isNil:
    quit "No certificate presented", QuitFailure

  let notAfter = cert.getNotAfter()
  let remaining = notAfter - now()

  echo "Certificate expires at: ", notAfter
  echo "Days remaining: ", remaining.inDays

  if remaining.inDays < 0:
    quit "Certificate expired", QuitFailure
  elif remaining.inDays < warnDays:
    quit "Certificate expiring soon", QuitFailure
  else:
    echo "Certificate OK"

when isMainModule:
  if paramCount() < 1:
    quit "Usage: cert-check <hostname>", QuitFailure

  checkCert(paramStr(1))
