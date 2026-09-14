//
//  WeekSelectorViewModelTests.swift
//  PeriodTTests
//

import Testing
import Foundation
@testable import PeriodT

@Suite("WeekSelectorViewModel")
struct WeekSelectorViewModelTests {

    let vm = WeekSelectorViewModel()
    let abbreviations = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

    @Test func currentMonthNameMatchesCalendar() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM"
        #expect(vm.currentMonthName == formatter.string(from: Date()))
    }

    @Test func currentDateNumberMatchesCalendar() {
        #expect(vm.currentDateNumber == Calendar.current.component(.day, from: Date()))
    }

    @Test func currentDateAbbreviationIsUppercaseThreeLetters() {
        #expect(abbreviations.contains(vm.currentDateAbrev))
    }

    @Test func weekHasSevenDaysMondayFirst() {
        let days = vm.days
        #expect(days.count == 7)
        #expect(days.map(\.day) == abbreviations)
    }

    @Test func weekContainsToday() {
        let todayNumber = Calendar.current.component(.day, from: Date())
        #expect(vm.days.contains { $0.day == vm.currentDateAbrev && $0.date == todayNumber })
    }

    @Test func weekDatesAreValidDaysOfMonth() {
        #expect(vm.days.allSatisfy { (1...31).contains($0.date) })
    }

    @Test func weekDayItemsHaveUniqueIds() {
        let ids = vm.days.map(\.id)
        #expect(Set(ids).count == 7)
    }
}
