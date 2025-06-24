//
//  Formatter.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-24.
//

import Foundation

func formatNeedleSize(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}

func formatDate(_ date: Date) -> String {
    return date.formatted(date: .abbreviated, time: .omitted)
}
