//
//  ExerciseProgram.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import SwiftUI

struct ExerciseProgram: Identifiable {
    let id = UUID()
    let date: Date
    let day: Int
    let exerciseDuration: Int
    let numberOfExercises: Int
    let exerciseType: ExerciseType
    
    var formattedDate: String {
        date.formattedProgramDate()
    }
    
    var color: Color {
        if dateNumber(date: date) >= dateNumber(date: Date()) {
            CoreColor.primary
        } else {
            CoreColor.lavender
        }
    }
    
    private let DateNumberFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    
    func dateNumber(date: Date) -> Int {
        Int(DateNumberFormatter.string(from: date)) ?? 0
    }
}
