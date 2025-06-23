//
//  YarnListView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-23.
//

import SwiftData
import SwiftUI

struct YarnListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Yarn.name) var yarns: [Yarn]

    @State private var showingAddYarnSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(yarns) { yarn in
                    NavigationLink(value: yarn) {
                        YarnRowView(yarn: yarn)
                    }
                }
            }
            .sheet(isPresented: $showingAddYarnSheet) {
                AddYarnView(project: nil)
                    .environment(\.modelContext, modelContext)
            }
            .navigationDestination(for: Yarn.self) { yarn in
                YarnDetailView(yarn: yarn)
            }
            .navigationTitle("Yarn Stash")
            .toolbar {
                ToolbarItem() {
                    Button {
                        showingAddYarnSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    YarnListView().modelContainer(mockContainerForYarnList())
}
