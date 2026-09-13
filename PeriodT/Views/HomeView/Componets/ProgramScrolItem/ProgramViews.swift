//
//  ProgramViews.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 12/9/2026.
//

import SwiftUI

struct ProgramViews: View {
    //MARK: DUMMY VARIABLES FOR PROGRAMS
    let programs = [
            ExerciseProgram(
                date: "MON 7 SEP",
                day: 1,
                exerciseDuration: 60,
                numberOfExercises: 6,
                exerciseType: .conditioningTraining

            ),
            ExerciseProgram(
                date: "WED 9 SEP",
                day: 2,
                exerciseDuration: 45,
                numberOfExercises: 5,
                exerciseType: .physio
            )
        ]

    //MARK: Formatting
    var body: some View {
        VStack(alignment: .leading, spacing:1){
            Text("My Programs")
                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(CoreColor.primary)
            Text("Here are your assigned workouts:")
                .font(.title3)
                .foregroundStyle(CoreColor.primary)

            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(){
                    ForEach(programs.prefix(5)) { program in
                        ProgramCard(program: program)
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ProgramViews()
}
