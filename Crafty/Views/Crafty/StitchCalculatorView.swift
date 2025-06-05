//
//  StitchCalculatorView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-05.
//

import SwiftUI

struct StitchCalculatorView: View {
    @State private var currentStitchCount = ""
    @State private var desiredStitchCount = ""

    @State private var flatInstruction: String = ""
    @State private var roundInstruction: String = ""
    @State private var errorMessage: String?

    @State private var showResults = false

    var isCurrentValid: Bool {
        Int(currentStitchCount) != nil && Int(currentStitchCount)! > 0
    }

    var isDesiredValid: Bool {
        Int(desiredStitchCount) != nil && Int(desiredStitchCount)! > 0
    }

    var isFormValid: Bool {
        isCurrentValid && isDesiredValid
    }

    var body: some View {
        NavigationView {
            Form {
                Text(
                    "To calculate how to increase or decrease your stitch count evenly, please enter your current and desired stitch count below."
                )
                Section {
                    VStack(alignment: .leading) {
                        TextField(
                            "Current stitch count",
                            text: $currentStitchCount
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: currentStitchCount) {
                            // Clear results and errors on input change
                            showResults = false
                            errorMessage = nil
                        }

                        if !isCurrentValid && !currentStitchCount.isEmpty {
                            Text("Enter a positive integer")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }

                    VStack(alignment: .leading) {
                        TextField(
                            "Desired stitch count",
                            text: $desiredStitchCount
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: desiredStitchCount) {
                            showResults = false
                            errorMessage = nil
                        }

                        if !isDesiredValid && !desiredStitchCount.isEmpty {
                            Text("Enter a positive integer")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }

                if showResults {
                    Section(header: Text("Instructions - Flat Knitting")) {
                        InstructionView(text: flatInstruction)
                    }

                    Section(
                        header: Text("Instructions - Knitting in the Round")
                    ) {
                        InstructionView(text: roundInstruction)
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
            .navigationTitle("Stitch Calculator")
        }
    }

    private func calculate() {
        guard let current = Int(currentStitchCount),
            let desired = Int(desiredStitchCount)
        else {
            errorMessage = "Please enter valid positive numbers"
            showResults = false
            return
        }

        let result = StitchCalculator.calculateInstructions(
            currentCount: current,
            desiredCount: desired
        )

        if let error = result.errorMessage {
            errorMessage = error
            showResults = false
            flatInstruction = ""
            roundInstruction = ""
        } else {
            errorMessage = nil
            flatInstruction = result.flatInstruction
            roundInstruction = result.roundInstruction
            showResults = true
        }
    }
}

struct InstructionView: View {
    let text: String
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 4)

            Button(action: {
                UIPasteboard.general.string = text
                withAnimation {
                    copied = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        copied = false
                    }
                }
            }) {
                HStack {
                    Image(systemName: "doc.on.doc")
                    Text(copied ? "Copied!" : "")
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(copied ? .green : .blue)
        }
    }
}

#Preview {
    StitchCalculatorView()
}
