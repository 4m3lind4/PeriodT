//
//  PollAnswersTests.swift
//  PeriodTTests
//

import Testing
import Foundation
import SwiftData
import SwiftUI
@testable import PeriodT

@Suite("PollAnswers")
@MainActor
struct PollAnswersTests {

    private let trained = PollQuestion(kind: .trained, text: "Trained?", color: .blue)
    private let onPeriod = PollQuestion(kind: .onPeriod, text: "On period?", color: .blue)

    @Test func initNormalisesDateToStartOfDay() throws {
        _ = try TestHelpers.makeContainer()
        let afternoon = Calendar.current.date(
            from: DateComponents(year: 2026, month: 9, day: 14, hour: 16, minute: 30)
        )!
        let record = PollAnswers(date: afternoon)
        #expect(record.date == TestHelpers.date(2026, 9, 14))
    }

    @Test func answersStartEmpty() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)
        #expect(record.answers.isEmpty)
        #expect(record.answer(for: trained) == nil)
    }

    @Test func setAndReadBackAnswers() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)

        record.setAnswer(.yes, for: trained)
        record.setAnswer(.no, for: onPeriod)

        #expect(record.answer(for: trained) == .yes)
        #expect(record.answer(for: onPeriod) == .no)
        #expect(record.answers == [.trained: .yes, .onPeriod: .no])
    }

    @Test func overwritingAnAnswerReplacesIt() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)
        record.setAnswer(.yes, for: trained)
        record.setAnswer(.no, for: trained)

        #expect(record.answer(for: trained) == .no)
        #expect(record.answers.count == 1)
    }

    @Test func fetchOrCreateInsertsWhenMissing() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        let day = TestHelpers.date(2026, 9, 10)

        let record = PollAnswers.fetchOrCreate(for: day, in: context)
        #expect(record.date == day)

        let all = try context.fetch(FetchDescriptor<PollAnswers>())
        #expect(all.count == 1)
    }

    @Test func fetchOrCreateReturnsExistingRecordForSameDay() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        let morning = Calendar.current.date(
            from: DateComponents(year: 2026, month: 9, day: 10, hour: 8)
        )!
        let evening = Calendar.current.date(
            from: DateComponents(year: 2026, month: 9, day: 10, hour: 21)
        )!

        let first = PollAnswers.fetchOrCreate(for: morning, in: context)
        first.setAnswer(.yes, for: trained)
        try context.save()

        let second = PollAnswers.fetchOrCreate(for: evening, in: context)
        #expect(second === first)
        #expect(second.answer(for: trained) == .yes)

        let all = try context.fetch(FetchDescriptor<PollAnswers>())
        #expect(all.count == 1)
    }

    @Test func fetchOrCreateKeepsDifferentDaysSeparate() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext

        _ = PollAnswers.fetchOrCreate(for: TestHelpers.date(2026, 9, 10), in: context)
        _ = PollAnswers.fetchOrCreate(for: TestHelpers.date(2026, 9, 11), in: context)
        try context.save()

        let all = try context.fetch(FetchDescriptor<PollAnswers>())
        #expect(all.count == 2)
    }

    @Test func answersSurviveSaveAndRefetch() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        let day = TestHelpers.date(2026, 9, 12)

        let record = PollAnswers.fetchOrCreate(for: day, in: context)
        record.setAnswer(.yes, for: onPeriod)
        try context.save()

        let fetched = try context.fetch(
            FetchDescriptor<PollAnswers>(predicate: #Predicate { $0.date == day })
        ).first
        #expect(fetched?.answers[.onPeriod] == .yes)
    }

    // MARK: Journal / emotion / intensity

    @Test func reviewFieldsStartEmpty() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)
        #expect(record.journal == "")
        #expect(record.emotion == nil)
        #expect(record.intensity == nil)
    }

    @Test func reviewFieldsSurviveSaveAndRefetch() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        let day = TestHelpers.date(2026, 9, 12)

        let record = PollAnswers.fetchOrCreate(for: day, in: context)
        record.journal = "Legs felt heavy"
        record.emotion = .stressed
        record.intensity = 1
        #expect(PollAnswers.save(context))

        let fetched = try context.fetch(
            FetchDescriptor<PollAnswers>(predicate: #Predicate { $0.date == day })
        ).first
        #expect(fetched?.journal == "Legs felt heavy")
        #expect(fetched?.emotion == .stressed)
        #expect(fetched?.intensity == 1)
    }

    @Test func clearingEmotionStoresNil() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)
        record.emotion = .happy
        record.emotion = nil
        #expect(record.emotion == nil)
    }

    @Test func everyEmotionRoundTripsThroughRawValue() throws {
        _ = try TestHelpers.makeContainer()
        let record = PollAnswers(date: .now)
        for emotion in Emotion.allCases {
            record.emotion = emotion
            #expect(record.emotion == emotion)
        }
    }

    @Test func saveReturnsTrueOnHealthyContext() throws {
        let container = try TestHelpers.makeContainer()
        let context = container.mainContext
        _ = PollAnswers.fetchOrCreate(for: .now, in: context)
        #expect(PollAnswers.save(context))
    }
}
