---
title: synchronization challenge in go
date: 2023-04-30
tags:
  - aca.github.io
  - go
---

Channel in go always amazes me when solving concurrency issues. Here's an
example.

When writing
[language server](https://microsoft.github.io/language-server-protocol/), I had
to generate a diagnostic report based on document changes with
textDocument/diagnostic[^1]. As document changes on every keyboard input and
diagnostic normally require heavy computation, there should be a way to throttle
requests. We don't want to mess up the UI with wrong diagnostics. It is quite
tricky in this situation.

[^1]: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_diagnostic

- Server only handles one request, put the next request in the queue.
- If another request comes in, the server should discard waiting request before
  enqueue.
- No lock. No sleep.

Here's my answer with one unbuffered, and one buffered channel.

- `DiagChan` is the main work queue with size of 1.
- `DiagReqChan` is the channel that actually receives request and does
  throttling.

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

func RunDiagnostic() {
	for v := range DiagChan {
		log.Println("[diag] start", v)
		defer log.Println("[diag] end", v)
		time.Sleep(time.Second)
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
