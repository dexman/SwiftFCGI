//
//  main.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/16/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import SwiftFCGI

struct StringWriter: OutputStreamType {

    let outputStream: NSOutputStream
    let encoding: NSStringEncoding

    mutating func write(string: String) {
        let data = string.dataUsingEncoding(self.encoding, allowLossyConversion: true)!
        let buffer = UnsafePointer<UInt8>(data.bytes)
        self.outputStream.write(buffer, maxLength: data.length)
    }

}

var requestNumber = 1
try SwiftFCGI.forEachRequest() { request in
    var writer = StringWriter(
        outputStream: request.output,
        encoding: NSUTF8StringEncoding
    )

    writer.write("Content-Type: text/html; charset=utf-8\r\n")
    writer.write("\r\n")
    writer.write("<html><head><title>SwiftFCGI</title></head><body>")
    writer.write("<p>Hello, <i>Swift</i>! This is request <b>\(requestNumber)</b></p>")
    writer.write("</body></html>")

    ++requestNumber
}
