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
    @State private var selectedCraft = Craft.knitting
    @State private var selectedStatus = Status.planning
    @State private var notes = ""
    @State private var startDate: Date = Date()
    @State private var endDate = Date()
    @State private var selectedYarn: [Yarn] = []
    @State private var isSaving = false

    var isTitleValid: Bool {
        title.isNotEmptyString
    }

    var isEndDateValid: Bool {
        selectedStatus != Status.finished || endDate >= startDate
    }

    private var isFormValid: Bool {
        isTitleValid && isEndDateValid
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Project Details") {
                    VStack(alignment: .leading) {
                        TextField("Enter a project name", text: $title)

                        if !isTitleValid && !title.isEmpty {
                            ErrorMessageView(message: "Project title is required")
                        }
                    }
                    
                    Picker("Craft Type", selection: $selectedCraft) {
                        ForEach(Craft.allCases, id: \.self) { craft in
                            Text(craft.rawValue.capitalized)
                                .tag(craft)
                        }
                    }.pickerStyle(.menu)
                }

                Section("Needle Size") {
                    Stepper(
                        "\(formatNeedleSize(needleSize))mm",
                        value: $needleSize,
                        in: 2...25,
                        step: 0.25
                    )
                }

                Section {
                    Picker("Project Status", selection: $selectedStatus) {
                        ForEach(Status.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized)
                                .tag(status)
                        }
                    }.pickerStyle(.menu)

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
                            in: startDate...Date.now,
                            displayedComponents: .date
                        )
                        if endDate < startDate {
                            ErrorMessageView(message: "Finish date cannot be before start date")
                        }
                    }
                    
                }

                Section("Notes (optional)") {
                    TextEditor(text: $notes)
                        .frame(height: 150)
                        .textSelection(.enabled)
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark", action: save)
                        .disabled(!isFormValid || isSaving)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(
                        "Cancel",
                        systemImage: "xmark",
                        action: { dismiss() }
                    )
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
        isSaving = true

        let newProject = Project(
            title: title,
            needleSize: needleSize,
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
