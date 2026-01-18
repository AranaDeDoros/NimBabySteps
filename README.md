# Nim CLI Experiments

Just for run.

Small CLI utilities written in Nim as learning exercises.

## Scripts

### 1. http-ping

A minimal HTTP latency checker.
Performs one or more HTTP (or HEAD) requests and reports response time.

**Usage**

```bash
nim c -r ping.nim <url> <nRequests> [--head]
nim c -r ping.nim https://example.com 5
```

### 2. certCheck

Checks the TLS certificate expiration date of a remote host. This was a PITA.

> _Requires a Unix-like environment with OpenSSL available(Linux/WSL recommended)._

**Usage**

```bash
nim c -r certCheck.nim <hostname>
nim c -r certCheck.nim example.com
```
