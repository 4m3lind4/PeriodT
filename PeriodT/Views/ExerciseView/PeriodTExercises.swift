//
//  PeriodTExercises.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct PeriodTExercises: View {
    var body: some View {
        VStack(alignment: .leading, spacing:1){
            Text ("Today's Program")
                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(CoreColor.primary)
            Text ("Exercise Programs")
                .font(.title2)
                .foregroundColor(CoreColor.primary)
            Text ("Physio Programs")
                .font(.title2)
                .foregroundColor(CoreColor.primary)


            
        }
    }
}

#Preview {
    PeriodTExercises()
}
