//
//  UITableViewCell+Extension.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 31/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
