//
//  PeriodTExercises.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct PeriodTExercises: View {
    var exerciseData: ExerciseMockData
    
    @State private var expandedProgramID: ExerciseProgram.ID?

    var exerciseProgram: [ExerciseProgram] {
        exerciseData.programs.filter { $0.exerciseType == .conditioningTraining }
    }
    var physioProgram: [ExerciseProgram] {
        exerciseData.programs.filter { $0.exerciseType == .physio }
    }

    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 12){
            HStack{
                
                Text ("Today's Program")
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(CoreColor.primary)
                
                Spacer()
                
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(CoreColor.lavender)
                    .font(.system(size: 50, weight: .bold))
            }
           
            Text ("Exercise Programs")
                .font(.title2)
                .foregroundColor(CoreColor.primary)
            ForEach(exerciseProgram) { program in
                ExpandableProgramCard(program: program, expandedProgramID: $expandedProgramID)
            }

            Text ("Physio Programs")
                .font(.title2)
                .foregroundColor(CoreColor.primary)
            ForEach(physioProgram) { program in
                ExpandableProgramCard(program: program, expandedProgramID: $expandedProgramID)
            }
        }
        .padding(10)
        }
    }
}

#Preview {
    PeriodTExercises(exerciseData: ExerciseMockData())
}
