//
//  PreviewData.swift
//  Crafty
//
//  Created by Ellen Fiscina on 2025-06-11.
//

import Fakery
import Foundation
import SwiftData

let faker = Faker()

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

func createMockProject() -> Project {
    return Project(
        title: "Scarf",
        needleSize: 4.25,
        size: "No size",
        yarns: [],
        craft: .knitting,
        status: .started,
        startDate: Date.now,
        notes: faker.lorem.paragraph()
    )
}

func mockProjectDetail() -> Project {
    let yarn = createMockYarn()
    let project = createMockProject()
    project.yarns.append(yarn)
    
    return project
}

func randomPastDate() -> Date {
    let secondsInDay: Int = 86400
    let randomInterval = TimeInterval(Int.random(in: 0..<10) * secondsInDay)
    return Date().addingTimeInterval(-randomInterval)
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
            needleSize: faker.number.randomDouble(min: 2.5, max:6),
            size: "Size \(i)",
            yarns: [yarn],
            craft: Craft.allCases.randomElement()!,
            status: status,
            startDate: status == .planning ? nil : randomPastDate(),
            endDate: status == .finished ? Date() : nil
        )
        context.insert(project)
    }

    try! context.save()
    return container
}

@MainActor func mockContainerForYarnList() -> ModelContainer {
    let container = createInMemoryContainer()
    let context = container.mainContext

    let project = createMockProject()
    context.insert(project)

    for _ in 1...5 {
        let yarn = Yarn(
            name: faker.commerce.productName(),
            maker: faker.company.name(),
            color: faker.commerce.color(),
            weight: [50, 100, 250].randomElement()!,
            yardage: faker.number.randomInt(min: 200, max: 1000),
            material: ["Cotton", "Wool", "Akryl"].randomElement()!,
            amount: faker.number.randomInt(min: 0, max: 10),
        )
        
        yarn.projects.insert(project, at: yarn.projects.endIndex)
        context.insert(yarn)
    }

    try! context.save()
    return container
}
