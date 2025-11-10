//
//  ContentView.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-04.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ProjectListView()
                .tabItem {
                    Label("Projects", systemImage: "folder.fill")
                }
                .tag(0)

            YarnListView()
                .tabItem {
                    Label("Stash", systemImage: "volleyball.fill")
                }
                .tag(1)

            GaugeCalculatorView()
                .tabItem {
                    Label("Gauge", systemImage: "ruler.fill")
                }
                .tag(2)

            StitchCalculatorView()
                .tabItem {
                    Label("Stitches", systemImage: "plus.forwardslash.minus")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
