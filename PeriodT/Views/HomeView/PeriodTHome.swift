//
//  PeriodTHome.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI
let viewModel = WeekSelectorViewModel()


struct PeriodTHome: View {
    var body: some View {
        ScrollView{
            VStack(spacing:1){
                HStack{
                    VStack(alignment: .leading){
                        Text ("Good Morning!")
                            .font(Font.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(CoreColor.primary)

                        Text ("Beth")
                            .font(Font.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(CoreColor.primary)

                        Text ("Today, \(viewModel.currentDateNumber) \(viewModel.currentMonthName)")
                            .font(.body)
                            .foregroundColor(CoreColor.primary)

                    }
                    Spacer()
                
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(CoreColor.lavender)
                        .font(.system(size: 50, weight: .bold))
    
                }
                .padding(.horizontal,10)
// MARK: ------ COMPLIATION OF ITEMS

                WeekSelector()
                Spacer()
                UpcomingEventCapsule( title: "National Team Selection", daysRemaining: 45)
                Spacer()
                CycleRingView()
                    .padding(30)
                ChartItem()
                Spacer()
                ProgramViews()
                    .padding(.horizontal,-20)
                HomeQuestionaireView()

            }
            .padding(10)
        }
        
    }
}



#Preview {
    PeriodTHome()
}
