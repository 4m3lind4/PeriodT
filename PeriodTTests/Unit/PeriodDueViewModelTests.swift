//
//  PeriodDueViewModelTests.swift
//  PeriodTTests
//

import Testing
import Foundation
import SwiftData
import SwiftUI
@testable import PeriodT

@Suite("PeriodDueViewModel")
@MainActor
struct PeriodDueViewModelTests {

    private func onPeriodQuestion() -> PollQuestion {
        PollQuestion(kind: .onPeriod, text: "Were you on your period?", color: .red)
    }

    /// Builds a `PollAnswers` record for `date` with the on-period answer set.
    private func answers(on date: Date, onPeriod: ReviewAnswer?) -> PollAnswers {
        let record = PollAnswers(date: date)
        if let onPeriod {
            record.setAnswer(onPeriod, for: onPeriodQuestion())
        }
        return record
    }

    @Test func returnsNotLoggedWhenNoAnswers() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()
        #expect(vm.lastReportedPeriod(in: []) == nil)
        #expect(vm.daysUntilNextPeriod(in: []) == nil)
        #expect(vm.dueText(for: []) == "Not logged")
    }

    @Test func ignoresDaysAnsweredNo() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()
        let list = [
            answers(on: TestHelpers.daysFromToday(-5), onPeriod: .no),
            answers(on: TestHelpers.daysFromToday(-3), onPeriod: nil),
        ]
        #expect(vm.lastReportedPeriod(in: list) == nil)
        #expect(vm.dueText(for: list) == "Not logged")
    }

    @Test func picksMostRecentYesDay() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()
        let list = [
            answers(on: TestHelpers.daysFromToday(-20), onPeriod: .yes),
            answers(on: TestHelpers.daysFromToday(-4), onPeriod: .yes),
            answers(on: TestHelpers.daysFromToday(-2), onPeriod: .no),
        ]
        #expect(vm.lastReportedPeriod(in: list) == TestHelpers.daysFromToday(-4))
    }

    @Test func daysUntilNextUsesCycleLength() throws {
        _ = try TestHelpers.makeContainer()
        var vm = PeriodDueViewModel()
        vm.cycleLength = 28
        let list = [answers(on: TestHelpers.daysFromToday(-10), onPeriod: .yes)]

        #expect(vm.daysUntilNextPeriod(in: list) == 18)
        #expect(vm.dueText(for: list) == "18 Days")

        vm.cycleLength = 21
        #expect(vm.daysUntilNextPeriod(in: list) == 11)
    }

    @Test func dueTextUsesSingularForOneDay() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()
        let list = [answers(on: TestHelpers.daysFromToday(-27), onPeriod: .yes)]
        #expect(vm.dueText(for: list) == "1 Day")
    }

    @Test func dueTextSaysDueTodayAtZeroDays() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()

        let dueToday = [answers(on: TestHelpers.daysFromToday(-28), onPeriod: .yes)]
        #expect(vm.daysUntilNextPeriod(in: dueToday) == 0)
        #expect(vm.dueText(for: dueToday) == "Due today")
    }

    /// A negative day count must never leak into the UI as "-2 Days".
    @Test func dueTextExplainsOverdueInsteadOfShowingNegativeNumber() throws {
        _ = try TestHelpers.makeContainer()
        let vm = PeriodDueViewModel()

        let overdue = [answers(on: TestHelpers.daysFromToday(-30), onPeriod: .yes)]
        #expect(vm.daysUntilNextPeriod(in: overdue) == -2)
        #expect(vm.dueText(for: overdue) == "Overdue by 2 Days")

        let overdueOne = [answers(on: TestHelpers.daysFromToday(-29), onPeriod: .yes)]
        #expect(vm.dueText(for: overdueOne) == "Overdue by 1 Day")
        #expect(!vm.dueText(for: overdue).contains("-"))
    }
}
