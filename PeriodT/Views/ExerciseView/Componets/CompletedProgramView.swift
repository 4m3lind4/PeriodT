//
//  CompletedProgramView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

struct CompletedProgramView: View {
    var body: some View {
        ZStack{
            CoreColor.primary
            VStack(alignment: .leading){
                Text("Great Job!")
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                PostWorkoutIntensity()
                Spacer()
                WorkoutJournalView()
            }
            .padding(10)

        }

    }
}

#Preview {
    CompletedProgramView()
}
