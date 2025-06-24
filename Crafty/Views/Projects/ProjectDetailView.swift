//
//  ProjectDetailView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-11.
//

import SwiftData
import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let project: Project

    @State private var showingAddYarnSheet = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image placeholder
                AsyncImage(
                    url: URL(string: "https://example.com/project-image.jpg")
                ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    if let start = project.startDate {
                        Text("Started: \(formatDate(start))")
                    }
                    if let end = project.endDate {
                        Text("Finished: \(formatDate(end))")
                    }
                }
                .font(.footnote)
                .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 8) {
                    Text(
                        "Needle Size: \(formatNeedleSize(project.needleSize))mm"
                    )
                    Text("Size: \(project.size)")
                    Text("Craft: \(project.craft.rawValue.capitalized)")
                    Text("Status: \(project.status.rawValue.capitalized)")
                }
                .font(.body)
                .padding(.vertical, 4)

                Divider()

                HStack {
                    Text("Yarns")
                        .font(.headline)
                    Spacer()
                    Button("Add Yarn") {
                        showingAddYarnSheet = true
                    }
                    .buttonStyle(.bordered)
                }
                
                if project.yarns.isEmpty {
                    Text("No yarn information")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(project.yarns, id: \.id) { yarn in
                            VStack(alignment: .leading) {
                                Text(yarn.name)
                                    .fontWeight(.medium)
                                Text("Color: \(yarn.color)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onDelete(perform: deleteYarns)
                    }
                    .frame(height: CGFloat(project.yarns.count * 60))
                    .listStyle(.plain)
                }

                Divider()

                if let notes = project.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notes")
                            .font(.headline)
                        Text(notes)
                            .font(.body)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showingAddYarnSheet) {
            AddYarnView(project: project)
                .environment(\.modelContext, modelContext)
        }
        .navigationTitle(project.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    func deleteYarns(at offsets: IndexSet) {
        for index in offsets {
            let yarn = project.yarns[index]
            modelContext.delete(yarn)
        }
    }
}

#Preview {
    NavigationStack {
        ProjectDetailView(project: mockProjectDetail())
    }
}
