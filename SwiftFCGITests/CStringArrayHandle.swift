//
//  CStringArrayHandle.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/16/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


class CStringArrayHandle {

    typealias MutableCStringArray = UnsafeMutablePointer<UnsafeMutablePointer<Int8>>

    let strings: [String]
    var array: MutableCStringArray

    init(_ strings: [String]) {
        self.strings = strings
        self.array = MutableCStringArray.alloc(strings.count + 1)
        var current = self.array
        strings.forEach() { string in
            string.withCString() { cString in
                current.memory = strdup(cString)
            }
            current = current.successor()
        }
        current.memory = UnsafeMutablePointer<Int8>()
    }

    deinit {
        var current = self.array
        while current.memory != UnsafeMutablePointer<Int8>() {
            free(current.memory)
            current = current.successor()
        }
        self.array.dealloc(self.strings.count + 1)
    }

}
