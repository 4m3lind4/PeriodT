//
//  ReviewAnswer.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import Foundation

/// Yes/no answer for a poll question. Raw string is what gets stored.
enum ReviewAnswer: String, Codable, Equatable {
    case yes
    case no
}
