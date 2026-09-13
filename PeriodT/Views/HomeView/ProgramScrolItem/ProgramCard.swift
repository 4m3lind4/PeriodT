//
//  ProgramCards.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI

enum ExerciseType {
    case physio
    case conditioningTraining
    
}

extension ExerciseType {
    var title: String {
        
        switch self {
            
        case .physio:
            return "Physio"

        case .conditioningTraining:
            return "Conditioning"
        }
    }
}



struct ExerciseProgram: Identifiable {
    let id = UUID()
    let date: String
    let day: Int
    let exerciseDuration: Int
    let numberOfExercises: Int
    let exerciseType: ExerciseType
    
}

struct ProgramCard: View {
    let program: ExerciseProgram
    
    private var cardColor: Color {
        switch program.exerciseType {
        case .physio:
            return CoreColor.primary

        case .conditioningTraining:
            return CoreColor.secondary
        }
    }
        

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(program.date)
                .font(.title3)

            Text("Day \(program.day) | \(program.exerciseType.title) ")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            Text(
                "\(program.numberOfExercises) Exercises – " + "\(program.exerciseDuration) Mins"
            )
            .font(.subheadline)
        }
        .padding(16)
        .frame(width: 230, height: 150, alignment: .leading)
        .foregroundStyle(.white)
        .background(CoreColor.primary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    ProgramCard(
        
        program: ExerciseProgram(
            date: "MON 7 SEP", day: 1, exerciseDuration: 60, numberOfExercises: 4, exerciseType: .physio
        )
        
    )
}
