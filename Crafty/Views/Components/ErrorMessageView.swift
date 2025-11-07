//
//  ErrorMessageView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-09.
//

import SwiftUI

struct ErrorMessageView: View {
    let message: String
    
    init(message: String = "Enter a positive integer") {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.caption)
    }
}
