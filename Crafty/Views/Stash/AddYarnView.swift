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
        weight.isPositiveInteger
    }
    
    var isYardageValid: Bool {
        yardage.isPositiveInteger
    }
    
    var isAmountValid: Bool {
        amount.isPositiveInteger
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Yarn Details") {
                    TextField("Name", text: $name)
                    TextField("Color", text: $color)
                    TextField("Maker", text: $maker)
                    TextField("Weight (g)", text: $weight)
                        .keyboardType(.numberPad)
                    TextField("Yardage (m)", text: $yardage)
                        .keyboardType(.numberPad)
                    TextField("Material", text: $material)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Yarn")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(name.isEmpty || color.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { dismiss() })
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
