//
//  DateFormatter.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//
import Foundation

extension Date {
    
    static var capitaliseFirstLetterOfWeek : [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols
        
        return weekdays.map { weekday in

            guard let firstLetter = weekday.first else { return "" }
                return String(firstLetter).capitalized
        }
    }
    
    static var fullMonthNames: [String] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1)) //Create a date with the given month name
            
            return date.map {dateFormatter.string(from: $0)}
        }
    }
    
    var StartOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var EndOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.StartOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: EndOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: StartOfMonth)
        let numberOfPreviousMonth = startOfMonthWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -numberOfPreviousMonth, to: StartOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        
        var days: [Date] = []
        
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: StartOfMonth)
            days.append(newDay!)
        }
                
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
                
        return days.filter { $0 >= sundayBeforeStart && $0 <= EndOfMonth }.sorted(by: <)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var nextMonth: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
