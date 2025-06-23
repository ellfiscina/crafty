//
//  YarnRowView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-23.
//

import SwiftUI

struct YarnRowView: View {
    let yarn: Yarn

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(yarn.name)
                    .font(.headline)
                Text("\(yarn.amount)")
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    YarnRowView(yarn: createMockYarn())
}
