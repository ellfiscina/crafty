//
//  CraftyApp.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-04.
//

import SwiftUI
import SwiftData

@main
struct CraftyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Project.self, Yarn.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
