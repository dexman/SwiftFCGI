//
//  OutputStream.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public class OutputStream: NSOutputStream {

    init(stream: UnsafeMutablePointer<FCGX_Stream>) {
        self.stream = stream
        super.init(toMemory: ())
    }

    public override func write(buffer: UnsafePointer<UInt8>, maxLength len: Int) -> Int {
        return Int(FCGX_PutStr(UnsafePointer<Int8>(buffer), Int32(len), self.stream))
    }

    public override var hasSpaceAvailable: Bool {
        get {
            return true
        }
    }

    let stream: UnsafeMutablePointer<FCGX_Stream>

}
