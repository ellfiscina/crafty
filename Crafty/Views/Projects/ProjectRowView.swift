//
//  ProjectRowView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-11.
//

import SwiftUI

struct ProjectRowView: View {
    let project: Project

    var body: some View {
        HStack {
            Image(project.craft.rawValue)
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)

            VStack(alignment: .leading) {
                Text(project.title)
                    .font(.headline)
                Text(project.status.rawValue)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ProjectRowView(project: mockProjectDetail())
}
