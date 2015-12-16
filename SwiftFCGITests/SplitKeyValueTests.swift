//
//  SplitKeyValueTests.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/16/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import XCTest
@testable import SwiftFCGI


class SplitKeyValueTests: XCTestCase {

    func testKeyPairPresent() {
        XCTAssertTrue(("foo", "bar") == splitKeyValue("foo=bar") ?? ("", ""))
    }

    func testKeyOnlyPresentWithEquals() {
        XCTAssertTrue(("foo", "") == splitKeyValue("foo=") ?? ("", ""))
    }

    func testKeyOnlyPresentWithoutEquals() {
        XCTAssertTrue(("foo", "") == splitKeyValue("foo") ?? ("", ""))
    }

    func testEmptyString() {
        XCTAssertNil(splitKeyValue(""))
    }

    func testMultipleKeyPairPresent() {
        XCTAssertTrue(("foo", "bar=baz") == splitKeyValue("foo=bar=baz") ?? ("", ""))
    }

}

func == <T:Equatable> (tuple1:(T,T),tuple2:(T,T)) -> Bool {
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}
