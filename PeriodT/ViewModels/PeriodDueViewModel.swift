//
//  PeriodDueViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

struct PeriodDueViewModel {
    var cycleLength = 28

    func lastReportedPeriod(in answers: [PollAnswers]) -> Date? {
        answers
            .filter { $0.answers[.onPeriod] == .yes }
            .map(\.date)
            .max()
    }

    func daysUntilNextPeriod(in answers: [PollAnswers]) -> Int? {
        guard let last = lastReportedPeriod(in: answers),
              let next = Calendar.current.date(byAdding: .day, value: cycleLength, to: last)
        else { return nil }
        return Calendar.current.dateComponents([.day], from: Date().startOfDay, to: next).day
    }

    func dueText(for answers: [PollAnswers]) -> String {
        guard let days = daysUntilNextPeriod(in: answers) else { return "Not logged" }
        return days == 1 ? "1 Day" : "\(days) Days"
    }
}
