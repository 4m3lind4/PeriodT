//
//  EmotionalLevel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

struct EmotionalLevel: Identifiable {
    let id = UUID()
    let day: String
    let menstrualLevel: Double
    let lutealLevel: Double
}
