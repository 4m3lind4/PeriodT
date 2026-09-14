//
//  PollAnswers.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import SwiftData

@Model
final class PollAnswers {
    @Attribute(.unique) var date: Date

    /// Stored as raw strings — SwiftData can't persist enum-keyed dictionaries.
    private var rawAnswers: [String: String] = [:]

    var answers: [PollQuestionKind: ReviewAnswer] {
        var result: [PollQuestionKind: ReviewAnswer] = [:]
        for (key, value) in rawAnswers {
            if let kind = PollQuestionKind(rawValue: key),
               let answer = ReviewAnswer(rawValue: value) {
                result[kind] = answer
            }
        }
        return result
    }

    init(date: Date) {
        self.date = date.startOfDay
    }

    func answer(for question: PollQuestion) -> ReviewAnswer? {
        rawAnswers[question.kind.rawValue].flatMap(ReviewAnswer.init(rawValue:))
    }

    func setAnswer(_ answer: ReviewAnswer, for question: PollQuestion) {
        rawAnswers[question.kind.rawValue] = answer.rawValue
    }

    static func fetchOrCreate(for day: Date, in context: ModelContext) -> PollAnswers {
        let start = day.startOfDay
        let descriptor = FetchDescriptor<PollAnswers>(
            predicate: #Predicate { $0.date == start }
        )
        if let existing = try? context.fetch(descriptor).first {
            return existing
        }
        let new = PollAnswers(date: start)
        context.insert(new)
        return new
    }
}
