//
//  InputStream.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public class InputStream: NSInputStream {

    init(stream: UnsafeMutablePointer<FCGX_Stream>) {
        self.stream = stream
        super.init(data: NSData())
    }

    public override func read(buffer: UnsafeMutablePointer<UInt8>, maxLength len: Int) -> Int {
        return Int(FCGX_GetStr(UnsafeMutablePointer<Int8>(buffer), Int32(len), self.stream))
    }

    public override func getBuffer(buffer: UnsafeMutablePointer<UnsafeMutablePointer<UInt8>>, length len: UnsafeMutablePointer<Int>) -> Bool {
        return false
    }

    public override var hasBytesAvailable: Bool {
        get {
            return FCGX_HasSeenEOF(self.stream) == 0
        }
    }

    let stream: UnsafeMutablePointer<FCGX_Stream>

}
