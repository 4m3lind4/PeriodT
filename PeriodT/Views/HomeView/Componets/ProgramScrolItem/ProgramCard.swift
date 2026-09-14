//
//  ProgramCards.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI


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
            Text(program.formattedDate)
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
        .frame(width: 250, height: 130, alignment: .leading)
        .foregroundStyle(.white)
        .background(program.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension Date {
    func formattedProgramDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self).uppercased()
    }
}

#Preview {
    ProgramCard(
        
        program: ExerciseProgram(
            date: Date(), day: 1, exerciseDuration: 60, numberOfExercises: 4, exerciseType: .physio, workouts: []
        )
        
    )
}
