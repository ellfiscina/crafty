//
//  Project.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-04.
//

import Foundation
import SwiftData

enum Craft: String, Codable, CaseIterable {
    case knitting
    case crochet
}

enum Status: String, Codable, CaseIterable {
    case planning
    case started
    case finished
}

@Model
final class Project {
    var title: String
    var needleSize: Double
    var size: String
    var yarns: [Yarn]
    var craft: Craft
    var status: Status
    var createdAt: Date
    var startDate: Date?
    var endDate: Date?
    var notes: String?

    
    init(title: String, needleSize: Double, size: String, yarns: [Yarn], craft: Craft, status: Status, startDate: Date? = nil, endDate: Date? = nil, notes: String? = nil) {
        self.title = title
        self.needleSize = needleSize
        self.size = size
        self.notes = notes
        self.yarns = yarns
        self.craft = craft
        self.status = status
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = Date()
    }
}
