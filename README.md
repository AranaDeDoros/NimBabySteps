# Nim First Steps

Just for run.

Small programs written in Nim for my learning experience.

## Scripts

### 1. http-ping

A minimal HTTP latency checker.
Performs one or more HTTP (or HEAD) requests and reports response time.

**Usage**

```bash
nim c -r ping.nim <url> <nRequests> [--head]
nim c -r ping.nim https://example.com 5
```

---

### 2. certCheck

Checks the TLS certificate expiration date of a remote host. This was a PITA.

> _Requires a Unix-like environment with OpenSSL available(Linux/WSL recommended)._

**Usage**

```bash
nim c -r certCheck.nim <hostname>
nim c -r certCheck.nim example.com
```

---

### 3. isPortInUse

Checks whether a port is in use.

**Usage**

```bash
nim c -r isPortInUse.nim <port> [port...]
nim c -r isPortInUse.nim 80 21
```

---

### 4. clipboardTest

Checks whether a file of some extension (images in this case) is currently copied to clipboard.

**Usage**

```bash
nim c -r clipboardTest.nim <port> [port...]
nim c -r clipboardTest.nim
```

---

### 5. hasher

Generates a sha256 hash of a file using streams. Useful when adding hashes to some whitelist.

**Usage**

```bash
nim c -r hasher [options [-d (for directories), -h]] <path>
nim c -r hasher your_path
```

---

### 6. docker dsl experiment

Macro to generate a really simple dockerfile using a dsl-like syntax.

**Usage**

```nim
when isMainModule:
  block:
    let d = dockerfile:
        base "python:3.9-slim"
        workdir "/app"
        copy "requirements.txt", "./"
        run "pip install --no-cache-dir -r requirements.txt"

    echo d
```

---
