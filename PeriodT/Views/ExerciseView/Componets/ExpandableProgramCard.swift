//
//  ExpandableProgramCard.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

struct ExpandableProgramCard: View {
    let program: ExerciseProgram
    @Binding var expandedProgramID: ExerciseProgram.ID?

    private var isExpanded: Bool { expandedProgramID == program.id }

    var body: some View {
        VStack(spacing: 0) {
            header

            if isExpanded {
                workoutList
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .background(CoreColor.ringBackground.opacity(isExpanded ? 0.6 : 0))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .animation(.snappy(duration: 0.3), value: isExpanded)
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(program.formattedDate)
                Text("Day \(program.day)")
                Text("\(program.numberOfExercises) Exercises - \(program.exerciseDuration) Mins")
            }
            .font(.system(size: 18, weight: .semibold, design: .rounded))

            Spacer()

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 22))
                .rotationEffect(.degrees(isExpanded ? 180 : 0))
        }
        .padding(16)
        .foregroundStyle(.white)
        .background(program.color)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(Rectangle())
        .onTapGesture {
            expandedProgramID = isExpanded ? nil : program.id
        }
    }

    private var workoutList: some View {
        VStack(spacing: 12) {
            ForEach(program.workouts) { workout in
                WorkoutRow(workout: workout)
            }
            // Pushes onto the NavigationStack owned by PeriodTExercises.
            NavigationLink {
                ActiveInProgramView(program: program)
            } label: {
                Text("Start")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(CoreColor.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: .black.opacity(0.2), radius: 0, y: 3)
            }
            .padding(.top, 8)
        }
        .padding(12)
    }
}

