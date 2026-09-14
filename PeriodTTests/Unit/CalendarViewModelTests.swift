//
//  CalendarViewModelTests.swift
//  PeriodTTests
//

import Testing
import Foundation
@testable import PeriodT

@Suite("CalendarViewModel")
struct CalendarViewModelTests {

    @Test func prePeriodDaysAreTheThreeDaysBeforeToday() {
        let vm = CalendarViewModel()

        #expect(vm.prePeriodDates.count == vm.amountOfPrePeriodDays)
        for offset in 1...vm.amountOfPrePeriodDays {
            #expect(vm.isPrePeriodDay(TestHelpers.daysFromToday(-offset)))
        }
        #expect(!vm.isPrePeriodDay(Date()))
        #expect(!vm.isPrePeriodDay(TestHelpers.daysFromToday(-(vm.amountOfPrePeriodDays + 1))))
    }

    @Test func periodStartsSevenDaysFromTodayAndRunsForSixDays() {
        let vm = CalendarViewModel()

        #expect(!vm.isPeriodDay(TestHelpers.daysFromToday(6)))
        for offset in 7..<(7 + vm.amountOfPeriodDays) {
            #expect(vm.isPeriodDay(TestHelpers.daysFromToday(offset)))
        }
        #expect(!vm.isPeriodDay(TestHelpers.daysFromToday(7 + vm.amountOfPeriodDays)))
    }

    @Test func secondCycleIsAppendedTwentyOneDaysAfterFirstEnds() {
        let vm = CalendarViewModel()

        // First cycle: today+7 ... today+12. Last day is +12, so the next
        // cycle starts at +33 and runs for another 6 days.
        let firstCycleLast = 7 + vm.amountOfPeriodDays - 1
        let secondStart = firstCycleLast + 21

        #expect(!vm.isPeriodDay(TestHelpers.daysFromToday(secondStart - 1)))
        for offset in secondStart..<(secondStart + vm.amountOfPeriodDays) {
            #expect(vm.isPeriodDay(TestHelpers.daysFromToday(offset)))
        }
        #expect(vm.periodDates.count == vm.amountOfPeriodDays * 2)
    }

    @Test func calculatePeriodDatesBuildsConsecutiveRun() {
        let vm = CalendarViewModel()
        let start = TestHelpers.date(2026, 3, 1)
        let run = vm.calculatePeriodDates(start)

        #expect(run.count == vm.amountOfPeriodDays)
        #expect(run.first == start)
        #expect(run.last == TestHelpers.date(2026, 3, vm.amountOfPeriodDays))
    }

    @Test func periodBatchesSplitsIntoTwoConsecutiveRuns() {
        let vm = CalendarViewModel()
        let batches = vm.periodBatches()

        #expect(batches.count == 2)
        #expect(batches.allSatisfy { $0.count == vm.amountOfPeriodDays })
        #expect(batches[0].last! < batches[1].first!)

        // Each batch must be strictly consecutive days.
        for batch in batches {
            for (a, b) in zip(batch, batch.dropFirst()) {
                let next = Calendar.current.date(byAdding: .day, value: 1, to: a)!
                #expect(Calendar.current.isDate(next, inSameDayAs: b))
            }
        }
    }

    @Test func periodBatchesHandlesUnsortedAndSingleDayRuns() {
        let vm = CalendarViewModel()
        vm.periodDates = [
            TestHelpers.date(2026, 5, 10),
            TestHelpers.date(2026, 5, 2),
            TestHelpers.date(2026, 5, 1),
            TestHelpers.date(2026, 5, 20),
        ]

        let batches = vm.periodBatches()
        #expect(batches.count == 3)
        #expect(batches[0] == [TestHelpers.date(2026, 5, 1), TestHelpers.date(2026, 5, 2)])
        #expect(batches[1] == [TestHelpers.date(2026, 5, 10)])
        #expect(batches[2] == [TestHelpers.date(2026, 5, 20)])
    }

    @Test func periodBatchesIsEmptyWhenNoDates() {
        let vm = CalendarViewModel()
        vm.periodDates = []
        #expect(vm.periodBatches().isEmpty)
    }

    @Test func dayChecksIgnoreTimeOfDay() {
        let vm = CalendarViewModel()
        let noonOnPeriodDay = Calendar.current.date(
            byAdding: .hour, value: 12, to: TestHelpers.daysFromToday(7)
        )!
        #expect(vm.isPeriodDay(noonOnPeriodDay))
    }

    /// `calculateNewMonthPeriod` used to force-unwrap `periodDates.last`,
    /// which crashed when no period days had been predicted.
    @Test func zeroPeriodDaysDoesNotCrashAndPredictsNothing() {
        let vm = CalendarViewModel()
        vm.amountOfPeriodDays = 0
        vm.periodDates = []

        vm.calculatePeriodTimes()
        vm.calculateNewMonthPeriod()

        #expect(vm.periodDates.isEmpty)
        #expect(vm.periodBatches().isEmpty)
        #expect(!vm.isPeriodDay(TestHelpers.daysFromToday(7)))
    }

    @Test func zeroPrePeriodDaysPredictsNothing() {
        let vm = CalendarViewModel()
        vm.amountOfPrePeriodDays = 0
        vm.calculatePrePeriodTime()

        #expect(vm.prePeriodDates.isEmpty)
        #expect(!vm.isPrePeriodDay(TestHelpers.daysFromToday(-1)))
    }
}
