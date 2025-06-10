//
//  Project.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-04.
//

import Foundation
import SwiftData

enum Craft: String, Codable {
    case knitting
    case crochet
}

enum Status: String, Codable {
    case planning
    case started
    case finished
}

@Model
final class Project {
    var title: String
    var needleSize: Double
    var size: String
    var notes: String?
    var yarns: [Yarn]
    var craft: Craft
    var status: Status
    
    init(title: String, needleSize: Double, size: String, notes: String? = nil, yarns: [Yarn], craft: Craft, status: Status) {
        self.title = title
        self.needleSize = needleSize
        self.size = size
        self.notes = notes
        self.yarns = yarns
        self.craft = craft
        self.status = status
    }
}
