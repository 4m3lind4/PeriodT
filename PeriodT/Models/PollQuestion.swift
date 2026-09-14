//
//  PollQuestion.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//
import Foundation
import SwiftUI

enum PollQuestionKind: String, Codable, CaseIterable {
    case trained
    case onPeriod
    case informCoachPeriod
    case informCoachWorkout
}

struct PollQuestion: Identifiable {
    let kind: PollQuestionKind
    let text: String
    let color: Color

    var id: PollQuestionKind { kind }
}
