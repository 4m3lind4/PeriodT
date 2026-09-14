//
//  ExerciseProgramTests.swift
//  PeriodTTests
//

import Testing
import Foundation
@testable import PeriodT

@Suite("ExerciseProgram")
struct ExerciseProgramTests {

    @Test func formattedDateMatchesDateExtension() {
        let date = TestHelpers.date(2026, 9, 15)
        let program = TestHelpers.makeProgram(date: date)
        #expect(program.formattedDate == "TUE 15 SEP")
        #expect(program.formattedDate == date.formattedProgramDate())
    }

    @Test func dateNumberReturnsDayOfMonth() {
        let program = TestHelpers.makeProgram()
        #expect(program.dateNumber(date: TestHelpers.date(2026, 9, 3)) == 3)
        #expect(program.dateNumber(date: TestHelpers.date(2026, 12, 31)) == 31)
    }

    @Test func upcomingProgramsUsePrimaryColour() {
        let today = TestHelpers.makeProgram(date: Date())
        #expect(today.color == CoreColor.primary)
        let tomorrow = TestHelpers.makeProgram(date: TestHelpers.daysFromToday(1))
        #expect(tomorrow.color == CoreColor.primary)
    }

    /// Colour used to compare day-of-month only, so a program from a
    /// previous month with a higher day number looked "upcoming".
    @Test func pastProgramsUseLavenderAcrossMonthBoundaries() {
        let yesterday = TestHelpers.makeProgram(date: TestHelpers.daysFromToday(-1))
        #expect(yesterday.color == CoreColor.lavender)

        // ~6 weeks ago: whatever its day-of-month, it's in the past.
        let lastMonth = TestHelpers.makeProgram(date: TestHelpers.daysFromToday(-40))
        #expect(lastMonth.color == CoreColor.lavender)
    }

    @Test func eachProgramHasUniqueId() {
        let a = TestHelpers.makeProgram()
        let b = TestHelpers.makeProgram()
        #expect(a.id != b.id)
        #expect(a != b)
    }

    @Test func workoutSetsAreOptional() {
        let timed = Workout(name: "Plank")
        let counted = Workout(name: "Squat", sets: 12)
        #expect(timed.sets == nil)
        #expect(counted.sets == 12)
    }

    @Test func mockDataIsWellFormed() {
        let programs = ExerciseMockData().programs
        #expect(programs.count == 2)
        #expect(programs.map(\.day) == [1, 2])
        #expect(programs.allSatisfy { !$0.workouts.isEmpty })
        #expect(programs.allSatisfy { $0.exerciseDuration > 0 })
        #expect(programs[0].exerciseType == .conditioningTraining)
        #expect(programs[1].exerciseType == .physio)
    }

    @Test func exerciseTypeTitles() {
        #expect(ExerciseType.physio.title == "Physio")
        #expect(ExerciseType.conditioningTraining.title == "Conditioning")
        #expect(ExerciseType.allCases.count == 2)
    }
}
