//
//  Calendar.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel

    @State private var date = Date.now

    private let daysOfWeek =
        Date.capitaliseFirstLetterOfWeek

    private let columns = Array(
        repeating: GridItem(.flexible()),
        count: 7
    )

    // Change 6 to the number of months you want.
    private var monthsArray: [Date] {
        (0..<3).compactMap { monthOffset in
            Calendar.current.date(
                byAdding: .month,
                value: monthOffset,
                to: date
            )
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(monthsArray, id: \.self) { month in
                    monthCalendar(for: month)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }

    private func monthCalendar(for month: Date) -> some View {
        VStack(spacing: 12) {
            Text(month, format: .dateTime.month(.wide))
                .font(.title3)
                .foregroundStyle(.black)

            Divider()

            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(4)
                }
            }

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(
                    month.calendarDisplayDays,
                    id: \.self
                ) { day in
                    calendarDay(day, in: month)
                }
            }
        }
    }

    @ViewBuilder
    private func calendarDay(
        _ day: Date,
        in month: Date
    ) -> some View {
        if day.monthInt != month.monthInt {
            Color.clear
                .frame(
                    maxWidth: .infinity,
                    minHeight: 40
                )
        } else {
            ZStack {
                dayBackground(for: day)

                Text(day.formatted(.dateTime.day()))
                    .foregroundStyle(CoreColor.primary)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 40
            )
        }
    }

    @ViewBuilder
    private func dayBackground(for day: Date) -> some View {
        if calendarViewModel.isPrePeriodDay(day) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(
                    Color("Third").opacity(0.8)
                )
        } else if calendarViewModel.isPeriodDay(day) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(
                    Color("Primary").opacity(0.8)
                )
        } else if Date.now.startOfDay == day.startOfDay {
            Circle()
                .foregroundStyle(.gray.opacity(0.3))
        } else {
            Color.clear
        }
    }
}

#Preview {
    CalendarView(
        calendarViewModel: CalendarViewModel()
    )
}
