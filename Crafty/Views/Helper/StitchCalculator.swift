//
//  StitchCalculator.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-05.
//

import Foundation

struct StitchCalculator {
    struct CalculationResult {
        let flatInstruction: String
        let roundInstruction: String
        let errorMessage: String?
    }
    
    static func calculateInstructions(currentCount: Int, desiredCount: Int) -> CalculationResult {
        guard currentCount > 0 else {
            return CalculationResult(flatInstruction: "", roundInstruction: "", errorMessage: "Current stitch count must be > 0")
        }
        
        guard desiredCount > 0 else {
            return CalculationResult(flatInstruction: "", roundInstruction: "", errorMessage: "Desired stitch count must be > 0")
        }
        
        let diff = desiredCount - currentCount
        let isIncrease = diff > 0
        let changes = abs(diff)
        
        if changes == 0 {
            let msg = "No increases or decreases needed. The stitch count is already \(currentCount)."
            return CalculationResult(flatInstruction: msg, roundInstruction: msg, errorMessage: nil)
        }
        
        // In the round calculations
        let divisorRound = changes
        let segmentSizeRound = currentCount / divisorRound
        
        let roundInstruction = buildInstruction(
            isIncrease: isIncrease,
            segmentSize: segmentSizeRound,
            extraBeg: 0,
            extraEnd: 0,
            numberOfChanges: changes,
            isInTheRound: true,
            leftoverStitches: 0,
            currentCount: currentCount
        )
        
        // Flat knitting calculations
        let divisorFlat = changes + 1
        let segmentSizeFlat = currentCount / divisorFlat
        let leftoverFlat = currentCount - segmentSizeFlat * divisorFlat
        let extraBegFlat = Int(ceil(Double(leftoverFlat) / 2.0))
        let extraEndFlat = leftoverFlat - extraBegFlat
        
        let flatInstruction = buildInstruction(
            isIncrease: isIncrease,
            segmentSize: segmentSizeFlat,
            extraBeg: extraBegFlat,
            extraEnd: extraEndFlat,
            numberOfChanges: changes,
            isInTheRound: false,
            leftoverStitches: leftoverFlat,
            currentCount: currentCount
        )
        
        return CalculationResult(flatInstruction: flatInstruction, roundInstruction: roundInstruction, errorMessage: nil)
    }
    
    static func buildInstruction(isIncrease: Bool,
                          segmentSize: Int,
                          extraBeg: Int,
                          extraEnd: Int,
                          numberOfChanges: Int,
                          isInTheRound: Bool,
                          leftoverStitches: Int,
                          currentCount: Int) -> String {
        
        let repeatSegment: String = {
            if isIncrease {
                return "m1, k\(segmentSize)"
            } else {
                let knitCount = max(0, segmentSize - 2)
                return "k\(knitCount), dec"
            }
        }()
        
        var parts: [String] = []
        
        if !isInTheRound && extraBeg > 0 {
            parts.append("k\(extraBeg)")
        }
        
        parts.append("(\(repeatSegment)) repeat \(numberOfChanges) times")
        
        if !isInTheRound && extraEnd > 0 {
            parts.append("k\(extraEnd)")
        }
        
        let instruction = parts.joined(separator: ", ")
        
        return instruction
    }
}
