//
//  ActiveInProgramView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

/// Checklist screen for the program the user has just started.
struct ActiveInProgramView: View {
    let program: ExerciseProgram
    @Environment(\.dismiss) private var dismiss
    @State private var completedWorkoutIDs: Set<Workout.ID> = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Today's Program")
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(CoreColor.primary)

                Spacer()

                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(CoreColor.lavender)
                    .font(.system(size: 50, weight: .bold))
            }
            .padding(10)

            ScrollView {
                VStack(spacing: 24) {
                    ForEach(program.workouts) { workout in
                        WorkoutChecklistRow(
                            workout: workout,
                            isChecked: Binding(
                                get: { completedWorkoutIDs.contains(workout.id) },
                                set: { checked in
                                    if checked {
                                        completedWorkoutIDs.insert(workout.id)
                                    } else {
                                        completedWorkoutIDs.remove(workout.id)
                                    }
                                }
                            )
                        )
                    }

                    Button {
                        // TODO: persist completed workouts, then go back.
                        dismiss()
                    } label: {
                        Text("Submit")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(CoreColor.primary)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                            .background(CoreColor.ringBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .black.opacity(0.2), radius: 0, y: 3)
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
            .background(CoreColor.primary)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    NavigationStack {
        ActiveInProgramView(program: ExerciseMockData().programs[1])
    }
}
