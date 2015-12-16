//
//  ArrayFromNullTerminatedArrayOfPointersTests.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/14/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import XCTest
@testable import SwiftFCGI


class ArrayFromNullTerminatedArrayOfPointersTests: XCTestCase {
    
    func testFullArray() {
        let handle = CStringArrayHandle(["Goodbye", "cruel", "world"])
        let result = SwiftFCGI.arrayFromNullTerminatedArrayOfPointers(handle.array)
        XCTAssert(arraysEqual(strings: handle.strings, cStrings: result))
    }

    func testOneArray() {
        let handle = CStringArrayHandle(["Hello"])
        let result = SwiftFCGI.arrayFromNullTerminatedArrayOfPointers(handle.array)
        XCTAssert(arraysEqual(strings: handle.strings, cStrings: result))
    }

    func testEmptyArray() {
        let handle = CStringArrayHandle([])
        let result = SwiftFCGI.arrayFromNullTerminatedArrayOfPointers(handle.array)
        XCTAssert(arraysEqual(strings: handle.strings, cStrings: result))
    }

    private func arraysEqual(strings strings: [String], cStrings: [UnsafeMutablePointer<Int8>]) -> Bool {
        if strings.count != cStrings.count {
            return false
        }
        return zip(strings, cStrings).reduce(true) { (equal, pair) in
            equal && stringEquals(pair.0, cString: pair.1)
        }
    }

    private func stringEquals(string: String, cString: UnsafeMutablePointer<Int8>) -> Bool {
        let result = string.withCString() { strcmp($0, cString) }
        return result == 0
    }

}
