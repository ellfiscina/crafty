//
//  Item.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-04.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
