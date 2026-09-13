//
//  ProgramViews.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 12/9/2026.
//

import SwiftUI

struct ProgramViews: View {
    var Date: String
    var Day: Int
    var ExerciseDuration: String
    var NumOFExercise: Int
    
    var body: some View {
    
        VStack(alignment: .leading, spacing:1){
            Text("My Programs")
                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(CoreColor.primary)
                .padding(.horizontal,12)

            //MARK: TO DO BE ABLE TO ADD A CAP OF 5 PROGRAMS FROM PHYSIO & PROGRAMS DUE
            ScrollView(.horizontal){
                HStack(spacing:1){
                    Rectangle()
                        .fill(CoreColor.primary)
                        .cornerRadius(12)
                        .padding(10)
                        .frame(width: 200, height: 120)
                    Rectangle()
                        .fill(CoreColor.primary)
                        .cornerRadius(12)
                        .padding(10)
                        .frame(width: 200, height: 120)
                }

                
            }

            

        }
        
    }
}

#Preview {
    ProgramViews(Date: "MON 7", Day: 1, ExerciseDuration: "60", NumOFExercise: 6)
}
