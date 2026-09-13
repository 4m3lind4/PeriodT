//
//  ChartView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI
import Charts

struct DailySales: Identifiable {
    let id = UUID()
    let day: String
    let amount: Double
    let other: Double
}

struct ChartView: View {
    let data: [DailySales] = [
            DailySales(day: "Mon", amount: 10, other: 20),
            DailySales(day: "Tue", amount: 25, other: 20),
            DailySales(day: "Wed", amount: 15, other: 20),
            DailySales(day: "Thu", amount: 40, other: 20),
            DailySales(day: "Fri", amount: 30, other: 20),
            DailySales(day: "Sat", amount: 40, other: 20),
            DailySales(day: "Sun", amount: 30, other: 20)
        ]

        var body: some View {
            Chart(data) { item in
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Amount", item.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Series", ""))
                
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Amount", item.other)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Series", "M"))
            }
//            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
//            .chartLegend(.hidden)
            .frame(height: 200)
            .padding()
            .background(CoreColor.white, in: RoundedRectangle(cornerRadius: 12))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding(12)
            
        }
}

#Preview {
    ChartView()
}
