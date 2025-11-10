//
//  CalculateButtonView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-11-10.
//

import SwiftUI

struct FullWidthButtonView: View {
    let label: String
    let isDisabled: Bool
    let action: () -> Void
    
    init(label: String = "Calculate", isDisabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Section {
            Button(label) {
                action()
            }
            .disabled(isDisabled)
            .frame(maxWidth: .infinity, minHeight: 50)
            .foregroundStyle(.white)
            .background(isDisabled ? Color.secondary : .accent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.headline)
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

