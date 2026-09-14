//
//  ModelTests.swift
//  PeriodTTests
//

import Testing
import Foundation
import SwiftUI
@testable import PeriodT

@Suite("Simple models")
struct ModelTests {

    @Test func emotionCasesAreUniqueAndSelfIdentified() {
        #expect(Emotion.allCases.count == 5)
        #expect(Set(Emotion.allCases).count == 5)
        for emotion in Emotion.allCases {
            #expect(emotion.id == emotion)
        }
    }

    @Test func eachEmotionHasDistinctImage() {
        let images = Emotion.allCases.map(\.image)
        #expect(Set(images).count == Emotion.allCases.count)
        #expect(Emotion.happy.image == .faceHappy)
        #expect(Emotion.stressed.image == .faceSad)
    }

    @Test func reviewAnswerRoundTripsThroughRawValue() {
        #expect(ReviewAnswer(rawValue: "yes") == .yes)
        #expect(ReviewAnswer(rawValue: "no") == .no)
        #expect(ReviewAnswer(rawValue: "maybe") == nil)
        #expect(ReviewAnswer.yes.rawValue == "yes")
    }

    @Test func reviewAnswerIsCodable() throws {
        let data = try JSONEncoder().encode([ReviewAnswer.yes, .no])
        let decoded = try JSONDecoder().decode([ReviewAnswer].self, from: data)
        #expect(decoded == [.yes, .no])
    }

    @Test func pollQuestionKindRawValuesAreStable() {
        // These strings are persisted in SwiftData — changing them breaks old data.
        #expect(PollQuestionKind.trained.rawValue == "trained")
        #expect(PollQuestionKind.onPeriod.rawValue == "onPeriod")
        #expect(PollQuestionKind.informCoachPeriod.rawValue == "informCoachPeriod")
        #expect(PollQuestionKind.informCoachWorkout.rawValue == "informCoachWorkout")
        #expect(PollQuestionKind.allCases.count == 4)
    }

    @Test func pollQuestionIdIsItsKind() {
        let q = PollQuestion(kind: .trained, text: "x", color: .red)
        #expect(q.id == .trained)
    }

    @Test @MainActor func dayPoleModelCoversEveryQuestionKindOnce() {
        let model = DayPoleModel()
        let kinds = model.questions.map(\.kind)
        #expect(kinds.count == PollQuestionKind.allCases.count)
        #expect(Set(kinds) == Set(PollQuestionKind.allCases))
        #expect(model.questions.allSatisfy { !$0.text.isEmpty })
    }

    @Test func selectedDayUsesDateAsId() {
        let date = TestHelpers.date(2026, 9, 14)
        let day = SelectedDay(id: date)
        #expect(day.date == date)
        #expect(day.id == date)
    }

    @Test func emotionalLevelHasUniqueIds() {
        let a = EmotionalLevel(day: "Mon", menstrualLevel: 1, lutealLevel: 2)
        let b = EmotionalLevel(day: "Mon", menstrualLevel: 1, lutealLevel: 2)
        #expect(a.id != b.id)
    }
}
