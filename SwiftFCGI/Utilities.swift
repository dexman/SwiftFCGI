//
//  Utilities.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/14/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


func synchronized<T>(lock: AnyObject, body: Void -> T) -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return body()
}

func arrayFromNullTerminatedArrayOfPointers<T>(array: UnsafeMutablePointer<UnsafeMutablePointer<T>>) -> [UnsafeMutablePointer<T>] {
    var result = [UnsafeMutablePointer<T>]()
    var current = array
    while current != nil && current.memory != UnsafeMutablePointer<T>() {
        result.append(current.memory)
        current = current.successor()
    }
    return result
}
