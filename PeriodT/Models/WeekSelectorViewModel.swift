//
//  WeekSelectorViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

struct WeekSelectorViewModel {
    let currentDate = Date()
    
    private let programDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    private let DateNumberFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var currentDateAbrev: String {
        programDateFormatter.string(from: currentDate).uppercased()
    }
    
    var currentDateNumber: Int {
        Int(DateNumberFormatter.string(from: currentDate))!
    }
    
    private var dateOffSet: Int {
        switch currentDateAbrev {
        case "MON": return 0
        case "TUE": return 1
        case "WED": return 2
        case "THU": return 3
        case "FRI": return 4
        case "SAT": return 5
        case "SUN": return 6
        default: return 0
        }
    }
    
    private var startOfWeek: Date {
        Calendar.current.date(byAdding: .day, value: -dateOffSet, to: currentDate) ?? currentDate
    }

    var days: [WeekDayItem] {
        (0..<7).map { offset in
            let date = Calendar.current.date(byAdding: .day, value: offset, to: startOfWeek) ?? startOfWeek
            return WeekDayItem(
                day: programDateFormatter.string(from: date).uppercased(),
                date: Int(DateNumberFormatter.string(from: date)) ?? 0
            )
        }
    }
}
