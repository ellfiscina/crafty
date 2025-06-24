//
//  YarnSelectionView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-24.
//

import SwiftData
import SwiftUI

struct YarnSelectionView<Selectable: Identifiable>: View {
    @Environment(\.modelContext) private var modelContext

    let options: [Selectable]
    let optionToString: (Selectable) -> String
    @Binding var selectedIDs: [Selectable.ID]

    @State private var showingAddYarnSheet = false
    @State private var searchText = ""

    private var filteredOptions: [Selectable] {
        if searchText.isEmpty {
            return options
        } else {
            return options.filter {
                optionToString($0).localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if options.isEmpty {
                Text("No yarns available. Add a yarn to get started.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List {
                    ForEach(filteredOptions) { option in
                        Button {
                            toggleSelection(for: option)
                        } label: {
                            Label {
                                Text(optionToString(option))
                                    .foregroundColor(.primary)
                            } icon: {
                                Image(
                                    systemName: selectedIDs.contains(option.id)
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .foregroundColor(
                                    selectedIDs.contains(option.id)
                                        ? .accentColor : .gray
                                )
                            }
                        }
                        .listRowBackground(
                            selectedIDs.contains(option.id)
                                ? Color.accentColor.opacity(0.1) : Color.clear
                        )
                    }
                }
                .listStyle(.insetGrouped)
                .searchable(text: $searchText)
            }
        }
        .sheet(isPresented: $showingAddYarnSheet) {
            AddYarnView(project: nil)
                .environment(\.modelContext, modelContext)
        }
        .navigationTitle("Select Yarns")
        .toolbar {
            ToolbarItem() {
                Button("Create Yarn") {
                    showingAddYarnSheet = true
                }
            }
        }
        
    }

    private func toggleSelection(for option: Selectable) {
        if let index = selectedIDs.firstIndex(of: option.id) {
            selectedIDs.remove(at: index)
        } else {
            selectedIDs.append(option.id)
        }
    }
}
