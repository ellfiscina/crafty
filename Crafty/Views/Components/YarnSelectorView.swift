//
//  YarnSelectorView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-24.
//

import SwiftData
import SwiftUI

struct YarnSelectorView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Yarn.name) private var yarns: [Yarn]

    @Binding var selected: [Yarn]

    private var selectedIDs: Binding<[PersistentIdentifier]> {
        Binding(
            get: { selected.map { $0.id } },
            set: { newIDs in
                selected = yarns.filter { newIDs.contains($0.id) }
            }
        )
    }

    var body: some View {
        NavigationLink {
            YarnSelectionView(
                options: yarns,
                optionToString: { $0.name },
                selectedIDs: selectedIDs
            )
        } label: {
            Text("Select Yarn")
        }
    }
}
