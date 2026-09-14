//
//  PeriodTTracking.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI
import SwiftData

struct PeriodTTracking: View {
    @Query(sort: \PollAnswers.date, order: .reverse)
    private var allAnswers: [PollAnswers]

    private let periodDue = PeriodDueViewModel()

    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 12){
                Text("Period Due")
                    .font(Font.system(size: 20, design: .rounded))
                    .foregroundColor(CoreColor.primary)
                Text(periodDue.dueText(for: allAnswers))
                    .font(Font.system(size: 30,weight: .bold, design: .rounded))
                    .foregroundColor(CoreColor.primary)
                    .frame(width: 300)
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(CoreColor.ringBackground)
                            .shadow(color: .black.opacity(0.25), radius: 0, x: 0, y: 2)

                    }
                GradientOverlayView()
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    PeriodTTracking()
}
