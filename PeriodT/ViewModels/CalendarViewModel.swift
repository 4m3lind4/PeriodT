//
//  CalendarViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class CalendarViewModel: ObservableObject {
    
    @Published var amountOfPrePeriodDays: Int = 3
    @Published var amountOfPeriodDays: Int = 6
    
    @Published var prePeriodDates: [Date] = []
    @Published var periodDates: [Date] = []
    
    init() {
        calculatePrePeriodTime()
        calculatePeriodTimes()
        calculateNewMonthPeriod()
    }
    
    func getAmountOfPeriodDays() -> Int {
        return amountOfPeriodDays
    }
    
    func getDaysBeforePeriod() -> Int {
        return 7
    }
    
    func isPrePeriodDay(_ day: Date) -> Bool {
        return prePeriodDates.contains { $0.startOfDay == day.startOfDay }
    }
    
    func calculatePrePeriodTime() {
        var prePeriodDates: [Date] = []
        
        for day in 0..<amountOfPrePeriodDays {
            prePeriodDates.append(Calendar.current.date(byAdding: .day, value: -(day + 1), to: Date())!)
        }
        
        self.prePeriodDates = prePeriodDates
    }
    
    func calculatePeriodTimes() {
        let startOfToday = Date().startOfDay
        let startOfPeriodDay = Calendar.current.date(byAdding: .day, value: 7, to: startOfToday)!
        
        self.periodDates = calculatePeriodDates(startOfPeriodDay)
    }
    
    func calculateNewMonthPeriod() {
        let lastPeriodDay = periodDates.sorted().last!
        let startOfNextPeriod = Calendar.current.date(byAdding: .day, value: 21, to: lastPeriodDay)!
        
        self.periodDates.append(contentsOf: calculatePeriodDates(startOfNextPeriod))
    }
    
    func calculatePeriodDates(_ startingDate: Date) -> [Date] {
        var periodDates: [Date] = []
        
        for day in 0..<amountOfPeriodDays {
            periodDates.append(Calendar.current.date(byAdding: .day, value: day, to: startingDate)!)
        }
        
        return periodDates
    }
    
    func isPeriodDay(_ day: Date) -> Bool {
        periodDates.contains { $0.startOfDay == day.startOfDay }
    }
    
    func isFirstPrePeriodDay(_ day: Date) -> Bool {
        let sortedPrePeriodArray = prePeriodDates.sorted()
        guard let first = sortedPrePeriodArray.first else { return false }
        return day.startOfDay == first.startOfDay
    }
    
    func isLastPrePeriodDay(_ day: Date) -> Bool {
        let sortedPrePeriodArray = prePeriodDates.sorted()
        guard let last = sortedPrePeriodArray.last else { return false }
        return day.startOfDay == last.startOfDay
    }
    
    func isFirstPeriodDay(_ day: Date) -> Bool {
        for batch in periodBatches() {
            if let first = batch.first, day.startOfDay == first.startOfDay {
                return true
            }
        }
        
        return false
    }
    
    func isLastPeriodDay(_ day: Date) -> Bool {
        for batch in periodBatches() {
            if let last = batch.last, day.startOfDay == last.startOfDay {
                return true
            }
        }
        
        return false
    }
    
    func periodBatches() -> [[Date]] {
        let sortedPeriodBatches = periodDates.sorted()
        var periodBatches: [[Date]] = []
        var currentBatch: [Date] = []
        
        for day in sortedPeriodBatches {
            if let last = currentBatch.last, Calendar.current.isDate(day, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: last)!) {
                currentBatch.append(day)
            } else {
                if !currentBatch.isEmpty {
                    periodBatches.append(currentBatch)
                }
                currentBatch = [day]
            }
        }
        
        if !currentBatch.isEmpty {
            periodBatches.append(currentBatch)
        }
        
        return periodBatches
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
