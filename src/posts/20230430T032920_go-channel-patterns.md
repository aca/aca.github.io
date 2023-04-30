---
title: go channel patterns
tags:
    - aca.github.io
---

Channel in go always amaze me how simple is to solve concurrency issues. Here's an example.

When writing language server, I had to generate diagnostic report based on document changes with [textDocument/diagnostic](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_diagnostic).
As document changes on every keyboard input and diagnostic normally requires heavy computation, there should be a way to throttle request.
Throttling is quite tricky if we want to make sure that diagnostic report is based on last modification.

Here's challenge.

- No lock. Just channels.
- Client makes request on every input.
- Server only handles one request, enqueue next request.
- If another request comes in, server should discard waiting request and enqueue.

Here's my answer with two channels.

```go
package main

import (
	"log"
	"time"
)

var (
	DiagChan    chan int = make(chan int, 1)
	DiagReqChan chan int = make(chan int)
)

func Diagnostic(v int) {
	log.Println("[diag] start", v)
	defer log.Println("[diag] end", v)
	time.Sleep(time.Second)
}

func RunDiagnostic() {
	for v := range DiagChan {
		Diagnostic(v)
	}
}

func HandleDiagnosticRequest() {
	for req := range DiagReqChan {
		select {
		case DiagChan <- req:
			log.Println("queued request", req)
		default:
			reqDiscarded := <-DiagChan
			log.Printf("discard %v, queued %v", reqDiscarded, req)
			DiagChan <- req
		}
	}
}

func main() {
	go RunDiagnostic()
	go HandleDiagnosticRequest()
	go func() {
		DiagReqChan <- 1
		DiagReqChan <- 2
		DiagReqChan <- 3
		DiagReqChan <- 4
		DiagReqChan <- 5
	}()
	select {}
}

```

```
queued request 1
queued request 2
discard 2, queued 3
discard 3, queued 4
discard 4, queued 5
[diag] start 1
[diag] end 1
[diag] start 5
[diag] end 5
```
