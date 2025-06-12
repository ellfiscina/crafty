//
//  GaugeCalculatorView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-05.
//

import SwiftUI

struct GaugeCalculatorView: View {
    @State private var gaugeStitchCount = ""
    @State private var gaugeWidth = ""
    @State private var finalWidth = ""
    @State private var result = ""

    @State private var errorMessage: String?

    @State private var showResults = false

    var isGaugeValid: Bool {
        gaugeStitchCount.isPositiveInteger
    }

    var isGaugeWidthValid: Bool {
        gaugeWidth.isPositiveInteger
    }

    var isFinalWidthValid: Bool {
        finalWidth.isPositiveInteger
    }

    var isFormValid: Bool {
        isGaugeValid && isGaugeWidthValid && isFinalWidthValid
    }

    var body: some View {
        NavigationView {
            Form {
                Text(
                    """
                    Use this calculator to adjust your stitch count based on your knitting gauge.

                    Enter the number of stitches and width from your current gauge swatch, then enter your desired final width.

                    The calculator will tell you how many stitches to cast on to achieve the target width.
                    """
                )
                Section {
                    VStack(alignment: .leading) {
                        TextField(
                            "Your gauge stitch count",
                            text: $gaugeStitchCount
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: gaugeStitchCount) {
                            reset()
                        }

                        if !isGaugeValid && !gaugeStitchCount.isEmpty {
                            ErrorMessageView()
                        }
                    }

                    VStack(alignment: .leading) {
                        TextField(
                            "Your gauge width (e.g., in cm)",
                            text: $gaugeWidth
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: gaugeWidth) {
                            reset()
                        }

                        if !isGaugeWidthValid && !gaugeWidth.isEmpty {
                            ErrorMessageView()
                        }
                    }

                    VStack(alignment: .leading) {
                        TextField(
                            "Final desired width",
                            text: $finalWidth
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: finalWidth) {
                            reset()
                        }

                        if !isFinalWidthValid && !finalWidth.isEmpty {
                            ErrorMessageView()
                        }
                    }
                }

                if showResults {
                    Section(header: Text("Result")) {
                        Text(result)
                    }
                }

                if let error = errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                Section {
                    Button("Calculate") {
                        calculate()
                    }
                    .disabled(!isFormValid)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Gauge Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func reset() {
        showResults = false
        errorMessage = nil
    }

    private func calculate() {
        guard let gaugeCountInt = Int(gaugeStitchCount),
            let gaugeWidthInt = Int(gaugeWidth),
            let finalWidthInt = Int(finalWidth)
        else {
            errorMessage = "Please enter valid positive numbers"
            showResults = false
            return
        }

        let desiredStitchCount = gaugeCountInt * finalWidthInt / gaugeWidthInt
        result =
            "You need to cast on \(desiredStitchCount) stitches to achieve the desired width."
        showResults = true
    }
}

#Preview {
    GaugeCalculatorView()
}
