//
//  VerticleProgramStackView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI


struct VerticleProgramStackView: View {
    var exerciseData: ExerciseMockData

    @State private var expandedProgramID: ExerciseProgram.ID?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(exerciseData.programs.prefix(5)) { program in
                    ExpandableProgramCard(
                        program: program,
                        expandedProgramID: $expandedProgramID
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}

#Preview {
    VerticleProgramStackView(exerciseData: ExerciseMockData())
}
