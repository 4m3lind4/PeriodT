//
//  DateCalendarTests.swift
//  PeriodTTests
//

import Testing
import Foundation
@testable import PeriodT

@Suite("Date+Calendar")
struct DateCalendarTests {

    // September 2026 starts on a Tuesday and has 30 days.
    let september = TestHelpers.date(2026, 9, 14)

    @Test func weekdayHeadersAreMondayFirstSingleLetters() {
        let headers = Date.capitaliseFirstLetterOfWeek
        #expect(headers.count == 7)
        #expect(headers.allSatisfy { $0.count == 1 })

        // First header should be the first letter of Monday's short symbol.
        let monday = Calendar.current.shortWeekdaySymbols[1]
        #expect(headers.first == String(monday.first!).capitalized)
        // Last header should be Sunday.
        let sunday = Calendar.current.shortWeekdaySymbols[0]
        #expect(headers.last == String(sunday.first!).capitalized)
    }

    @Test func fullMonthNamesHasTwelveUniqueEntries() {
        let names = Date.fullMonthNames
        #expect(names.count == 12)
        #expect(Set(names).count == 12)
        #expect(names.allSatisfy { !$0.isEmpty })
    }

    @Test func startAndEndOfMonth() {
        #expect(september.StartOfMonth == TestHelpers.date(2026, 9, 1))
        #expect(september.EndOfMonth == TestHelpers.date(2026, 9, 30))
        #expect(september.numberOfDaysInMonth == 30)
    }

    @Test func februaryLeapYearHandling() {
        #expect(TestHelpers.date(2024, 2, 10).numberOfDaysInMonth == 29)
        #expect(TestHelpers.date(2026, 2, 10).numberOfDaysInMonth == 28)
    }

    @Test func startOfPreviousMonthCrossesYearBoundary() {
        let january = TestHelpers.date(2026, 1, 20)
        #expect(january.startOfPreviousMonth == TestHelpers.date(2025, 12, 1))
        #expect(september.startOfPreviousMonth == TestHelpers.date(2026, 8, 1))
    }

    @Test func nextMonthAndMonthInt() {
        #expect(september.monthInt == 9)
        #expect(september.nextMonth.monthInt == 10)
        #expect(TestHelpers.date(2026, 12, 5).nextMonth.monthInt == 1)
    }

    @Test func mondayBeforeStartIsAMondayOnOrBeforeTheFirst() {
        // 1 Sept 2026 is a Tuesday, so the Monday before is 31 Aug.
        #expect(september.mondayBeforeStart == TestHelpers.date(2026, 8, 31))

        // 1 June 2026 is a Monday, so it should return itself.
        let june = TestHelpers.date(2026, 6, 10)
        #expect(june.mondayBeforeStart == TestHelpers.date(2026, 6, 1))

        // Regardless of month, the result must be a Monday.
        for month in 1...12 {
            let d = TestHelpers.date(2026, month, 15)
            #expect(Calendar.current.component(.weekday, from: d.mondayBeforeStart) == 2)
        }
    }

    @Test func calendarDisplayDaysPadsToMondayAndIsSorted() {
        let days = september.calendarDisplayDays

        // 31 Aug (Mon) + 30 days of Sept = 31 entries.
        #expect(days.count == 31)
        #expect(days.first == TestHelpers.date(2026, 8, 31))
        #expect(days.last == TestHelpers.date(2026, 9, 30))
        #expect(days == days.sorted())
        #expect(days.first!.isFirstDayOfRow)
    }

    @Test func calendarDisplayDaysHasNoPaddingWhenMonthStartsOnMonday() {
        let june = TestHelpers.date(2026, 6, 10)
        let days = june.calendarDisplayDays
        #expect(days.count == 30)
        #expect(days.first == TestHelpers.date(2026, 6, 1))
    }

    @Test func calendarDisplayDaysAreConsecutive() {
        let days = september.calendarDisplayDays
        for (a, b) in zip(days, days.dropFirst()) {
            let next = Calendar.current.date(byAdding: .day, value: 1, to: a)!
            #expect(Calendar.current.isDate(next, inSameDayAs: b))
        }
    }

    @Test func rowBoundaries() {
        let monday = TestHelpers.date(2026, 9, 14)
        let sunday = TestHelpers.date(2026, 9, 20)
        let wednesday = TestHelpers.date(2026, 9, 16)

        #expect(monday.isFirstDayOfRow)
        #expect(!monday.isLastDayOfRow)
        #expect(sunday.isLastDayOfRow)
        #expect(!sunday.isFirstDayOfRow)
        #expect(!wednesday.isFirstDayOfRow && !wednesday.isLastDayOfRow)
    }

    @Test func startOfDayStripsTime() {
        let withTime = Calendar.current.date(
            from: DateComponents(year: 2026, month: 9, day: 14, hour: 15, minute: 42, second: 7)
        )!
        #expect(withTime.startOfDay == TestHelpers.date(2026, 9, 14))
    }

    @Test func formattedProgramDateIsUppercasedShortForm() {
        // 14 Sept 2026 is a Monday.
        #expect(TestHelpers.date(2026, 9, 14).formattedProgramDate() == "MON 14 SEP")
        #expect(TestHelpers.date(2026, 1, 1).formattedProgramDate() == "THU 1 JAN")
    }
}
