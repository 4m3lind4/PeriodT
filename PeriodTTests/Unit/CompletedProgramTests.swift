//
//  CompletedProgramTests.swift
//  PeriodTTests
//

import Testing
import Foundation
import SwiftData
@testable import PeriodT

@Suite("CompletedProgram")
@MainActor
struct CompletedProgramTests {

    @Test func copiesProgramFieldsAndNormalisesDate() throws {
        _ = try TestHelpers.makeContainer()
        let afternoon = Calendar.current.date(
            from: DateComponents(year: 2026, month: 9, day: 15, hour: 14)
        )!
        let program = TestHelpers.makeProgram(date: afternoon, day: 3, type: .conditioningTraining)

        let record = CompletedProgram(program: program, completedWorkouts: ["Squat"])

        #expect(record.date == TestHelpers.date(2026, 9, 15))
        #expect(record.programDay == 3)
        #expect(record.exerciseType == "Conditioning")
        #expect(record.completedWorkouts == ["Squat"])
        #expect(abs(record.submittedAt.timeIntervalSinceNow) < 5)
    }

    @Test func allowsEmptyCompletedWorkouts() throws {
        _ = try TestHelpers.makeContainer()
        let record = CompletedProgram(program: TestHelpers.makeProgram(), completedWorkouts: [])
        #expect(record.completedWorkouts.isEmpty)
    }

    @Test func persistsAndFetchesByDate() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        let day = TestHelpers.date(2026, 9, 15)
        let program = TestHelpers.makeProgram(date: day)

        context.insert(CompletedProgram(program: program, completedWorkouts: ["Squat", "Plank"]))
        try context.save()

        let fetched = try context.fetch(
            FetchDescriptor<CompletedProgram>(predicate: #Predicate { $0.date == day })
        )
        #expect(fetched.count == 1)
        #expect(fetched.first?.completedWorkouts == ["Squat", "Plank"])
        #expect(fetched.first?.exerciseType == "Physio")
    }
}
