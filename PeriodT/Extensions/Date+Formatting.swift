//
//  Date+Formatting.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

extension Date {
    /// e.g. "MON 14 SEP"
    func formattedProgramDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self).uppercased()
    }
}
