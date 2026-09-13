//
//  PeriodTHome.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

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

                        
                        Text ("Today, 13 September")
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
                UpcomingEventCapsule( title: "National Team Selection", daysRemaining: 45)
                Spacer()
                CycleRingView()
                Spacer()
                ChartItem()
                Spacer()
                ProgramViews()
                    .padding(.horizontal,-20)

            }
            .padding(10)
        }
        
    }
}



#Preview {
    PeriodTHome()
}
