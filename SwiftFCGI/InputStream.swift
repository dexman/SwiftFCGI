//
//  InputStream.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public struct InputStream {

    public func read(length: Int) throws -> NSData {
        let data = NSMutableData(length: length)!
        let buffer = UnsafeMutablePointer<Int8>(data.mutableBytes)
        data.length = try readBlock(buffer, length: length)
        return data
    }

    public func readAll() throws -> NSData {
        let data = NSMutableData()
        while true {
            let block = try read(InputStream.BlockSize)
            data.appendData(block)
            if block.length < InputStream.BlockSize {
                // end of file
                break
            }
        }
        return data
    }

    private static let BlockSize = 8192

    let stream: UnsafeMutablePointer<FCGX_Stream>

    private func readBlock(buffer: UnsafeMutablePointer<Int8>, length: Int) throws -> Int {
        let bytesRead = Int(FCGX_GetStr(buffer, Int32(length), stream))
        if bytesRead < 0 {
            throw IOError.ReadError
        }
        return bytesRead
    }

}
