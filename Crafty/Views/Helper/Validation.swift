//
//  Validation.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-09.
//

import Foundation

extension String {
    var isPositiveInteger: Bool {
        if let intValue = Int(self), intValue > 0 {
            return true
        }
        return false
    }
}
