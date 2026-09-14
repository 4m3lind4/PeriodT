//
//  TestHelpers.swift
//  PeriodTTests
//

import Foundation
import SwiftData
@testable import PeriodT

/// Shared fixtures for unit tests.
enum TestHelpers {

    /// Builds a date at midnight in the current calendar. Tests use fixed
    /// dates so results don't drift with the wall clock.
    static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
    }

    static func daysFromToday(_ offset: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: offset, to: Date().startOfDay)!
    }

    /// Throw-away in-memory SwiftData container so tests never touch disk.
    @MainActor
    static func makeContainer() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(for: PollAnswers.self, CompletedProgram.self, configurations: config)
    }

    static func makeProgram(
        date: Date = date(2026, 9, 15),
        day: Int = 1,
        duration: Int = 45,
        type: ExerciseType = .physio,
        workouts: [Workout] = [Workout(name: "Squat", sets: 10), Workout(name: "Plank")]
    ) -> ExerciseProgram {
        ExerciseProgram(
            date: date,
            day: day,
            exerciseDuration: duration,
            numberOfExercises: workouts.count,
            exerciseType: type,
            workouts: workouts
        )
    }
}
