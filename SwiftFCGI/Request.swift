//
//  Request.swift
//  SwiftFCGI
//
//  Created by Arthur Dexter on 12/10/15.
//  Copyright © 2015 Arthur Dexter. All rights reserved.
//

import Foundation


public struct Request {

    let environment: [String: String]
    let input: InputStream
    let output: OutputStream
    let error: OutputStream

}


