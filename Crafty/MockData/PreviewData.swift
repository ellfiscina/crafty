//
//  PreviewData.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-11.
//

import Foundation
import SwiftData

func createInMemoryContainer() -> ModelContainer {
    try! ModelContainer(
        for: Schema([Project.self, Yarn.self]),
        configurations: [.init(isStoredInMemoryOnly: true)]
    )
}

func createMockYarn() -> Yarn {
    return Yarn(
        name: "Cotton 8/4",
        maker: "Yarnspirations",
        color: "White",
        weight: 100,
        yardage: 400,
        material: "Cotton",
        amount: 2
    )
}

func mockProjectDetail() -> Project {
    let yarn = createMockYarn()

    return Project(
        title: "Scarf",
        needleSize: 4.25,
        size: "No size",
        yarns: [yarn],
        craft: .knitting,
        status: .started,
        startDate: Date.now,
        notes: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tincidunt vestibulum libero. Suspendisse gravida posuere enim in porta. Nullam non risus urna. Ut ut lectus urna. Donec eros ante, faucibus ac sem eu, congue lacinia nisl. Integer facilisis consequat justo. Sed viverra id massa at ultricies. Aenean at lobortis urna. Vivamus luctus suscipit lectus, ut elementum augue consequat eget. Nulla tristique molestie lectus, sit amet sodales ligula consectetur ut. Vestibulum pellentesque semper metus a convallis.
            """
    )
}

@MainActor func mockContainerForProjectList() -> ModelContainer {
    let container = createInMemoryContainer()
    let context = container.mainContext

    let yarn = createMockYarn()
    context.insert(yarn)

    for i in 1...5 {
        let status = Status.allCases.randomElement()!
        let project = Project(
            title: "Project \(i)",
            needleSize: 3.5 + Double(i),
            size: "Size \(i)",
            yarns: [yarn],
            craft: Craft.allCases.randomElement()!,
            status: status,
            startDate: status == .planning ? nil : Date(),
            endDate: status == .finished ? Date() : nil
        )
        context.insert(project)
    }

    try! context.save()
    return container
}
