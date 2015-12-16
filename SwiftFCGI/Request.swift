//
//  Request.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public struct Request {

    public let environment: [String: String]
    public let input: InputStream
    public let output: OutputStream
    public let error: OutputStream

}


