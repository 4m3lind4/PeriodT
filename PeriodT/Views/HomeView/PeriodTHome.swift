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

                CycleRingView()
                
                UpcomingEventCapsule( title: "National Team Selection", daysRemaining: 45)
                
                VStack(alignment: .leading, spacing:1){
                    Text("The Forcast")
                        .font(Font.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(CoreColor.primary)
                        .padding(.horizontal,12)

                    Capsule(upperText: "Upcoming Event", lowerText: "Nationals Team Selection", systemimage: nil ,type: .withoutImage)

                }


                
            }
        }
        
    }
}



#Preview {
    PeriodTHome()
}
