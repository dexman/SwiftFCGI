//
//  BuildEnvironmentTests.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/16/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import XCTest
@testable import SwiftFCGI


class BuildEnvironmentTests: XCTestCase {

    let environmentHandle = CStringArrayHandle([
        "a=b=c",
        "d=e",
        "f=",
        "g",
        ""
    ])
    var request = FCGX_Request()
    var environment = [String:String]()

    override func setUp() {
        super.setUp()
        self.request.envp = environmentHandle.array
        self.environment = SwiftFCGI.buildEnvironment(request)
    }

    func testEnvionrmentContents() {
        let expected = [
            "a": "b=c",
            "d": "e",
            "f": "",
            "g": "",
        ]
        XCTAssertEqual(expected, self.environment)
    }

}
