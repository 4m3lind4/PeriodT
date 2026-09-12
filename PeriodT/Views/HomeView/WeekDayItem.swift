//
//  WeekDayItem.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 12/9/2026.
//

import SwiftUI

struct WeekDayItem: Identifiable{
    let id = UUID()
    let day: String
    let date: Int
}

struct WeekSelector: View {

    let days: [WeekDayItem] = [
        WeekDayItem(day: "TUE", date: 7),
        WeekDayItem(day: "WED", date: 8),
        WeekDayItem(day: "THU", date: 9),
        WeekDayItem(day: "FRI", date: 10),
        WeekDayItem(day: "SAT", date: 11),
        WeekDayItem(day: "SUN", date: 12),
        WeekDayItem(day: "MON", date: 13)
    ]

    @State private var selectedDate: Int = 7

    var body: some View {

        HStack(spacing: 0) {

            ForEach(days) { item in

                VStack(spacing: 12) {

                    Text(item.day)
                        .font(.system(size: 18, weight: .bold))

                    Text("\(item.date)")
                        .font(.system(size: 22))
                }
                .foregroundStyle(
                    selectedDate == item.date
                    ? Color.white
                    : CoreColor.primary
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    Group {
                        if selectedDate == item.date {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(CoreColor.primary)
                        }
                    }
                )
                .onTapGesture {
                    selectedDate = item.date
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(CoreColor.ringBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
//        .shadow(
//            color: .black.opacity(0.18),
//            radius: 5,
//            x: 0,
//            y: 4
//        )
        .padding()
    }
}

#Preview {
    WeekSelector()
}
