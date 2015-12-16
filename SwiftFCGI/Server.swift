//
//  Server.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public func forEachRequest(body: (Request) throws -> ()) rethrows {
    dispatch_once(&initToken) {
        FCGX_Init()
    }

    var fcgxRequest = FCGX_Request()
    FCGX_InitRequest(&fcgxRequest, 0, 0)

    while true {
        let res = synchronized(acceptLock) {
            FCGX_Accept_r(&fcgxRequest)
        }
        if 0 != res {
            break
        }

        let request = Request(
            environment: buildEnvironment(fcgxRequest),
            input: InputStream(stream: fcgxRequest.`in`),
            output: OutputStream(stream: fcgxRequest.out),
            error: OutputStream(stream: fcgxRequest.err)
        )

        defer {
            FCGX_Finish_r(&fcgxRequest)
        }

        try body(request)
    }
}

func buildEnvironment(fcgxRequest: FCGX_Request) -> [String: String] {
    return arrayFromNullTerminatedArrayOfPointers(fcgxRequest.envp)
        .flatMap() { String.fromCString($0) }
        .flatMap() { splitKeyValue($0) }
        .reduce([:]) { (var dict, elem) in dict[elem.0] = elem.1; return dict }
}


func splitKeyValue(keyAndValue: String) -> (String, String)? {
    let parts = keyAndValue
        .characters
        .split("=", maxSplit: 1, allowEmptySlices: true)
        .map() { String($0) }

    if parts.count == 1 && !parts[0].isEmpty {
        return (parts[0], "")
    } else if parts.count == 2 {
        return (parts[0], parts[1])
    } else {
        return nil
    }
}

private var initToken: dispatch_once_t = 0
private let acceptLock = 0
