//
//  AddProjectView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-23.
//

import SwiftData
import SwiftUI

struct AddProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var needleSize = 5.0
    @State private var size = ""
    @State private var selectedCraft = Craft.knitting
    @State private var selectedStatus = Status.planning
    @State private var notes = ""
    @State private var startDate: Date = Date()
    @State private var endDate = Date()
    @State private var selectedYarn: [Yarn] = []

    var body: some View {
        NavigationView {
            Form {
                Section("Project Details") {
                    TextField("Title", text: $title)
                    Stepper(
                        "\(formatNeedleSize(needleSize))mm",
                        value: $needleSize,
                        in: 2...25,
                        step: 0.25
                    )
                    TextField("Size", text: $size)
                    Picker("Select your craft", selection: $selectedCraft) {
                        ForEach(Craft.allCases, id: \.self) { craft in
                            Text(craft.rawValue.capitalized)
                                .tag(craft)
                        }
                    }
                }

                Section("Status") {
                    Picker("Select the status", selection: $selectedStatus) {
                        ForEach(Status.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized)
                                .tag(status)
                        }
                    }

                    if selectedStatus != Status.planning {
                        DatePicker(
                            "Start date",
                            selection: $startDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        )
                    }

                    if selectedStatus == Status.finished {
                        DatePicker(
                            "Finished date",
                            selection: $endDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        )
                    }
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 150)
                }

                Section("Yarn") {
                    YarnSelectorView(
                        selected: $selectedYarn
                    )
                    List {
                        ForEach(selectedYarn) { yarn in
                            YarnRowView(yarn: yarn)
                        }
                        .onDelete(perform: deleteYarns)
                    }
                }
            }
            .animation(.default, value: selectedStatus)
            .navigationTitle("Add Project")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { dismiss() })
                }
            }
        }
    }
    
    func deleteYarns(at offsets: IndexSet) {
        for index in offsets {
            selectedYarn.remove(at: index)
        }
    }

    func save() {
        let newProject = Project(
            title: title,
            needleSize: needleSize,
            size: size,
            yarns: selectedYarn,
            craft: selectedCraft,
            status: selectedStatus,
            startDate: selectedStatus != Status.planning ? startDate : nil,
            endDate: selectedStatus == Status.finished ? endDate : nil,
            notes: notes
            )
            
        modelContext.insert(newProject)

        dismiss()
    }
}

#Preview {
    AddProjectView().modelContainer(mockContainerForYarnList())
}
