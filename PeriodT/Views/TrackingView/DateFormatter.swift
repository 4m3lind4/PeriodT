//
//  DateFormatter.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//
import Foundation

//Extends the current properties of Date
extension Date {
    
    //Returns an array of string with the first letter of each weekday
    static var capitaliseFirstLetterOfWeek : [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols //Create an array that gets the short version of the weekday names e.g. Mon, Tue
        
        //Loops through the array filled with the weekday names
        return weekdays.map { weekday in
            //Gets the first letter of the weekday word. If empty, it returns an empty string
            guard let firstLetter = weekday.first else { return "" }
                return String(firstLetter).capitalized
        }
    }
    
    //Returns a string array variable that lists all the 12th month names
    static var fullMonthNames: [String] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current //Ensures the month names matches whatever name is used based on user's locale
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1)) //Create a date with the given month name
            
            //If the date exist, format it to the month name
            return date.map {dateFormatter.string(from: $0)}
        }
    }
    
    //Returns a date variable that contains the first day of the current month
    var StartOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    //Returns a date variable that contains the end day of the current month
    var EndOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    //Returns a date variable that contains the first day of the last (month before current) month
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.StartOfMonth
    }
    
    //Returns an integer variable that contains the amount of days for the current month
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: EndOfMonth)
    }
    
    //Returns a date variable that contains the sunday at the beginning of the calendar week
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
