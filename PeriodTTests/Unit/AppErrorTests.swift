//
//  AppErrorTests.swift
//  PeriodTTests
//

import Testing
import Foundation
@testable import PeriodT

/// The copy shown on the error card, and which errors auto-dismiss.
@Suite("AppError")
struct AppErrorTests {

    @Test func futureDayTitleIsTheTappedDay() {
        let day = TestHelpers.date(2026, 9, 21)
        let error = AppError.futureDay(day)
        #expect(error.title == day.formatted(.dateTime.weekday(.wide).day()))
        #expect(error.message.contains("not available yet"))
    }

    @Test func saveFailedNamesWhatWasBeingSaved() {
        #expect(AppError.saveFailed(.workout).message.contains("your workout"))
        #expect(AppError.saveFailed(.journal).message.contains("your journal"))
        #expect(AppError.saveFailed(.pollAnswer).message.contains("your answer"))
        #expect(AppError.saveFailed(.workout).title == "Couldn't save")
    }

    @Test func dataUnavailableTellsUserNothingWillBeKept() {
        let error = AppError.dataUnavailable
        #expect(error.title == "Your data couldn't be loaded")
        #expect(error.message.contains("won't be kept"))
    }

    /// Future-day and save errors slide away after a few seconds; a missing
    /// store is a session-long problem and must stay until dismissed.
    @Test func onlyTransientErrorsAutoDismiss() {
        #expect(AppError.futureDay(.now).autoDismisses)
        #expect(AppError.saveFailed(.pollAnswer).autoDismisses)
        #expect(!AppError.dataUnavailable.autoDismisses)
    }

    @Test func errorsAreDistinguishableForTaskRestart() {
        // `.task(id:)` relies on equality to restart the dismiss timer.
        let a = AppError.futureDay(TestHelpers.date(2026, 9, 21))
        let b = AppError.futureDay(TestHelpers.date(2026, 9, 22))
        #expect(a != b)
        #expect(a == AppError.futureDay(TestHelpers.date(2026, 9, 21)))
        #expect(AppError.saveFailed(.journal) != AppError.saveFailed(.workout))
    }
}
