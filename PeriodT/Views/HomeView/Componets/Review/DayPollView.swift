//
//  DayPollView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI
import SwiftData

/// The stack of poll question cards for a single day, reading and
/// writing answers straight into that day's `PollAnswers` record.
struct DayPollView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = DayPoleModel()

    let day: Date

    @State private var record: PollAnswers?

    var body: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.questions) { question in
                QuestionCardView(
                    selectedAnswer: Binding(
                        get: { record?.answer(for: question) },
                        set: { newValue in
                            guard let newValue else { return }
                            let target = record
                                ?? PollAnswers.fetchOrCreate(for: day, in: modelContext)
                            target.setAnswer(newValue, for: question)
                            record = target
                        }
                    ),
                    question: question.text,
                    color: question.color
                )
            }
            EmotionPollView()
            IntensitySliderView()
            JournalView()
        }
        .onAppear {
            record = PollAnswers.fetchOrCreate(for: day, in: modelContext)
        }
    }
}

#Preview {
    DayPollView(day: .now)
        .modelContainer(for: PollAnswers.self, inMemory: true)
}
