//
//  AddYarnView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-11.
//

import SwiftData
import SwiftUI

struct AddYarnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let project: Project?

    @State private var name = ""
    @State private var color = ""
    @State private var maker = ""
    @State private var weight = ""
    @State private var yardage = ""
    @State private var material = ""
    @State private var amount = ""

    var isWeightValid: Bool {
        weight.isEmpty || weight.isPositiveInteger
    }
    
    var isYardageValid: Bool {
        yardage.isEmpty || yardage.isPositiveInteger
    }
    
    var isAmountValid: Bool {
        amount.isEmpty || amount.isPositiveInteger
    }
    
    var isNameValid: Bool {
        name.isNotEmptyString
    }
    
    var isColorValid: Bool {
        color.isNotEmptyString
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Yarn Details") {
                    TextField("Name", text: $name)
                    TextField("Color", text: $color)
                    TextField("Maker", text: $maker)
                    VStack(alignment: .leading) {
                        TextField("Weight (g)", text: $weight)
                        .keyboardType(.numberPad)

                        if !isWeightValid {
                            ErrorMessageView()
                        }
                    }
                    VStack(alignment: .leading) {
                        TextField("Yardage (m)", text: $yardage)
                        .keyboardType(.numberPad)

                        if !isYardageValid {
                            ErrorMessageView()
                        }
                    }
                    TextField("Material", text: $material)
                    VStack(alignment: .leading) {
                        TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)

                        if !isAmountValid {
                            ErrorMessageView()
                        }
                    }
                }
            }
            .navigationTitle("Add Yarn")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark", action: save)
                        .disabled(!(isNameValid || isColorValid))
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark", action: { dismiss() })
                }
            }
        }
    }

    func save() {
        let newYarn = Yarn(
            name: name,
            maker: maker,
            color: color,
            weight: Int(weight) ?? 0,
            yardage: Int(yardage) ?? 0,
            material: material,
            amount: Int(amount) ?? 0
        )
        
        if let project {
            newYarn.projects.append(project)
            project.yarns.append(newYarn)
        }
        
        modelContext.insert(newYarn)

        dismiss()
    }
}


#Preview {
    AddYarnView(project: mockProjectDetail())
}
