//
//  WAHTTPRequestMethod.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

enum WAHTTPRequestMethod: String {
    case get
    case post
    case put
    case delete
    
    var value: String {
        self.rawValue.uppercased()
    }
}
