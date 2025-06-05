//
//  StitchCalculatorTests.swift
//  CraftyTests
//
//  Created by Ellen Fiscina on 2025-06-05.
//

import XCTest

@testable import Crafty

final class StitchCalculatorTests: XCTestCase {

    func testBuildInstruction_Increase_Flat_WithExtras() {
        let result = StitchCalculator.buildInstruction(
            isIncrease: true,
            segmentSize: 7,
            extraStart: 2,
            extraEnd: 1,
            numberOfChanges: 10,
            isInTheRound: false,
        )

        let expected =
            "k2, (k7, m1) repeat 10 times, k1"
        XCTAssertEqual(result, expected)
    }

    func testBuildInstruction_Decrease_InTheRound_NoExtras() {
        let result = StitchCalculator.buildInstruction(
            isIncrease: false,
            segmentSize: 8,
            extraStart: 0,
            extraEnd: 0,
            numberOfChanges: 5,
            isInTheRound: true,
        )

        let expected = "(k6, k2tog) repeat 5 times"
        XCTAssertEqual(result, expected)
    }

    func testBuildInstruction_Decrease_Flat_NoExtras() {
        let result = StitchCalculator.buildInstruction(
            isIncrease: false,
            segmentSize: 5,
            extraStart: 0,
            extraEnd: 0,
            numberOfChanges: 4,
            isInTheRound: false,
        )

        let expected = "(k3, k2tog) repeat 4 times"
        XCTAssertEqual(result, expected)
    }

    func testBuildInstruction_Increase_InTheRound_NoExtras() {
        let result = StitchCalculator.buildInstruction(
            isIncrease: true,
            segmentSize: 10,
            extraStart: 0,
            extraEnd: 0,
            numberOfChanges: 3,
            isInTheRound: true,
        )

        let expected = "(k10, m1) repeat 3 times"
        XCTAssertEqual(result, expected)
    }

    func testNoChange() {
        let result = StitchCalculator.calculateInstructions(
            currentCount: 50,
            desiredCount: 50
        )
        XCTAssertNil(result.errorMessage)
        XCTAssertEqual(
            result.flatInstruction,
            "No increases or decreases needed. The stitch count is already 50."
        )
        XCTAssertEqual(
            result.roundInstruction,
            "No increases or decreases needed. The stitch count is already 50."
        )
    }

    func testInvalidCurrentCount() {
        let result = StitchCalculator.calculateInstructions(
            currentCount: 0,
            desiredCount: 100
        )
        XCTAssertEqual(result.errorMessage, "Current stitch count must be > 0")
    }

    func testInvalidDesiredCount() {
        let result = StitchCalculator.calculateInstructions(
            currentCount: 80,
            desiredCount: 0
        )
        XCTAssertEqual(result.errorMessage, "Desired stitch count must be > 0")
    }

    func testIncreaseExample() {
        let result = StitchCalculator.calculateInstructions(
            currentCount: 80,
            desiredCount: 90
        )
        XCTAssertNil(result.errorMessage)

        let expectedFlat =
            "k2, (k7, m1) repeat 10 times, k8"
        XCTAssertEqual(result.flatInstruction, expectedFlat)

        let expectedRound = "(k8, m1) repeat 10 times"
        XCTAssertEqual(result.roundInstruction, expectedRound)
    }

    func testDecreaseExample() {
        let result = StitchCalculator.calculateInstructions(
            currentCount: 80,
            desiredCount: 70
        )
        XCTAssertNil(result.errorMessage)

        let expectedFlat =
            "k2, (k5, k2tog) repeat 10 times, k8"
        XCTAssertEqual(result.flatInstruction, expectedFlat)

        let expectedRound =
            "(k6, k2tog) repeat 10 times"
        XCTAssertEqual(result.roundInstruction, expectedRound)
    }
}
