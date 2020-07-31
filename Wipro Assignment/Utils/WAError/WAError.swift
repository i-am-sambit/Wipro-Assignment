//
//  WAError.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 31/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

enum WAError: Error {
    case api(message: String)
    case operation(message: String)
    case validation(message: String)
    
    var message: String {
        switch self {
            
        case .api(message: let message):
            return message
        case .operation(message: let message):
            return message
        case .validation(message: let message):
            return message
        }
    }
}
