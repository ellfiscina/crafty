//
//  Yarn.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-10.
//

import Foundation
import SwiftData

@Model
final class Yarn {
    var name: String
    var maker: String
    var color: String
    var weight: Int
    var yardage: Int
    var material: String
    var amount: Int
    @Relationship(inverse: \Project.yarns) var projects: [Project]
    
    init(name: String, maker: String, color: String, weight: Int, yardage: Int, material: String, amount: Int) {
        self.name = name
        self.maker = maker
        self.color = color
        self.weight = weight
        self.yardage = yardage
        self.material = material
        self.amount = amount
        self.projects = []
    }
}
