//
//  PollViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import Combine

final class PollViewModel: ObservableObject {
    @Published var questions: [PollQuestion] = [
        PollQuestion(text: "Did you practice or train today?", color: CoreColor.secondary),
        PollQuestion(text: "Were you on your period?", color: CoreColor.secondary),
        PollQuestion(text: "Would you like to inform your coach about your period?", color: CoreColor.secondary),
        PollQuestion(text: "Would you like to update your coach about your Workout?", color: CoreColor.secondary)
    ]

    @Published var answers: [UUID: ReviewAnswer] = [:]

    func answer(for question: PollQuestion) -> ReviewAnswer? {
        answers[question.id]
    }

    func setAnswer(_ answer: ReviewAnswer, for question: PollQuestion) {
        answers[question.id] = answer
    }
}
