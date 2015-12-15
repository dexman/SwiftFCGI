//
//  OutputStream.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public struct OutputStream {

    public func write(data: NSData) throws {
        let res = FCGX_PutStr(UnsafePointer<Int8>(data.bytes), Int32(data.length), stream)
        if res == -1 {
            throw IOError.WriteError
        }
    }

    let stream: UnsafeMutablePointer<FCGX_Stream>

}
