//
//  YarnDetailView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-23.
//

import SwiftData
import SwiftUI

struct YarnDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let yarn: Yarn
    
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

                VStack(alignment: .leading, spacing: 8) {
                    Text("Brand: \(yarn.maker)")
                    Text("Color: \(yarn.color)")
                    Text("Weight: \(yarn.weight)g")
                    Text("Yardage: \(yarn.yardage)m")
                    Text("Material: \(yarn.material)")
                    Text("Amount: \(yarn.amount)")
                }
                .font(.body)
                .padding(.vertical, 4)

                Divider()

                Text("Projects")
                    .font(.headline)

                if yarn.projects.isEmpty {
                    Text("No project information")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(yarn.projects, id: \.id) { project in
                            VStack(alignment: .leading) {
                                Text(project.title)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .frame(height: CGFloat(yarn.projects.count * 60))
                    .listStyle(.plain)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(yarn.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    YarnDetailView(yarn: createMockYarn())
}
