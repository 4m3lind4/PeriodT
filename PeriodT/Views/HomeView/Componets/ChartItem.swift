//
//  ChartItem.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI


struct ChartItem: View {
    
    var body: some View {
        //HEADING
        VStack(alignment: .leading, spacing: 1){
            Text("Period Forecast")
                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(CoreColor.primary)
                .padding(.horizontal, 12)

            //FIRST BODY OF TECT
            VStack(alignment: .center, spacing: 12) {
                Text("By being in the luteal phase you should expect to feeling emotionally intense in practice due to PMS.")
                    .multilineTextAlignment(.center)
                    .padding(1)
                    .foregroundStyle(CoreColor.primary)
                    .font(.body)
                Text("Your Emotional States")
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                    .padding(-5)
                    .foregroundColor(CoreColor.primary)
                

                ChartView()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(CoreColor.white)
                    }
                HStack{
                    //TODO: UPDATE THIS TO BE SIMPLIFIED
                    Text("Menstruation")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(5)
                        .frame( height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 10 )                               .fill(CoreColor.primary)
                            )
                    Text("Follicular")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(5)
                        .frame( height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 10 )                               .fill(CoreColor.accent)
                            )
                    Text("Ovulation")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(5)
                        .frame( height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 10 )                               .fill(CoreColor.yellow)
                            )
                    Text("Luteal")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(5)
                        .frame(width: 60, height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 10 )                               .fill(CoreColor.secondary)
                            )
                    
                }
                
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(CoreColor.ringBackground)
            }
        }
    }
}

#Preview {
    ChartItem()
}

