# SwiftFCGI

FCGI Swift bindings to libfcgi. Allows you to write web programs in Swift.

# Example

### main.swift:

```swift
try SwiftFCGI.forEachRequest() { request in
  let string = "Content-Type: text/html; charset=utf-8\r\n\r\nHello, <i>Swift</i>!"
  let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
  request.output.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
}
```

### lighttpd configuration

```
server.port = 8080
server.document-root = "/tmp"
server.modules = ("mod_fastcgi", "mod_rewrite")

url.rewrite-once = (
    "(.*)" => "/app/$1"
)

fastcgi.server = (
    "/app" => ((
        "socket" => "/tmp/test.fastcgi.socket",
        "check-local" => "disable",
        "bin-path" => "</path/to/my/program>",
        "min-procs" => 1,
        "max-procs" => 1,
        "idle-timeout" => 30
    ))
)
```

# License

Licensed under the Apache License, Version 2.0. See LICENSE file.
