//
//  ProjectListView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-10.
//

import SwiftData
import SwiftUI

struct ProjectListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Project.createdAt, order: .reverse) var projects: [Project]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        ProjectRowView(project: project)
                    }
                }
                .onDelete(perform: deleteProjects)

            }
            .navigationDestination(for: Project.self) { project in
                ProjectDetailView(project: project)
            }
            .navigationTitle("Projects")
        }
    }
    
    func deleteProjects(at offsets: IndexSet) {
        for index in offsets {
            let project = projects[index]
            modelContext.delete(project)
        }
    }
}

#Preview {
    ProjectListView().modelContainer(mockContainerForProjectList())
}
