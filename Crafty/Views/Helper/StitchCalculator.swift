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
            return CalculationResult(
                flatInstruction: "",
                roundInstruction: "",
                errorMessage: "Current stitch count must be > 0"
            )
        }

        guard desiredCount > 0 else {
            return CalculationResult(
                flatInstruction: "",
                roundInstruction: "",
                errorMessage: "Desired stitch count must be > 0"
            )
        }

        let diff = desiredCount - currentCount
        let isIncrease = diff > 0
        let numberOfChanges = abs(diff)

        if numberOfChanges == 0 {
            let msg = "No increases or decreases needed. The stitch count is already \(currentCount)."
            return CalculationResult(
                flatInstruction: msg,
                roundInstruction: msg,
                errorMessage: nil
            )
        }

        let numberSegments = numberOfChanges + 1
        let segmentSizeFlat = currentCount / numberSegments
        
        var extraEnd: Int = segmentSizeFlat
        var extraStart: Int = 0
        
        if currentCount % numberSegments != 0 {
            let usedStitches = segmentSizeFlat * numberSegments
            let extraStitches = currentCount - usedStitches
            
            extraStart = Int(ceil(Double(extraStitches) / 2.0))
            extraEnd += extraStitches - extraStart
        }

        let flatInstruction = buildInstruction(
            isIncrease: isIncrease,
            segmentSize: segmentSizeFlat,
            extraStart: extraStart,
            extraEnd: extraEnd,
            numberOfChanges: numberOfChanges,
            isInTheRound: false,
        )

        let segmentSizeRound = currentCount / numberOfChanges

        let roundInstruction = buildInstruction(
            isIncrease: isIncrease,
            segmentSize: segmentSizeRound,
            extraStart: 0,
            extraEnd: currentCount % numberOfChanges == 0 ? 0 : segmentSizeRound,
            numberOfChanges: numberOfChanges,
            isInTheRound: true,
        )

        return CalculationResult(
            flatInstruction: flatInstruction,
            roundInstruction: roundInstruction,
            errorMessage: nil
        )
    }

    static func buildInstruction(
        isIncrease: Bool,
        segmentSize: Int,
        extraStart: Int,
        extraEnd: Int,
        numberOfChanges: Int,
        isInTheRound: Bool,
    ) -> String {
        let action = isIncrease ? "m1" : "k2tog"
        let repeatStitchCount = isIncrease ? segmentSize : max(1, segmentSize - 2)

        let repeatPart = "(k\(repeatStitchCount), \(action)) repeat \(numberOfChanges) times"
        let start = extraStart > 0 ? "k\(extraStart), " : ""
        let end = extraEnd > 0 ? ", k\(extraEnd)" : ""

        return start + repeatPart + end
    }
}
