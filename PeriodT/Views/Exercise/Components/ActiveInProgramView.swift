//
//  ActiveInProgramView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI
import SwiftData
import OSLog

/// Checklist screen for the program the user has just started.
struct ActiveInProgramView: View {
    private static let logger = Logger(subsystem: "PeriodT", category: "ActiveInProgramView")

    let program: ExerciseProgram
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @Environment(\.presentError) private var presentError
    // IDs of workouts the user has ticked so far.
    @State private var completedWorkoutIDs: Set<Workout.ID> = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScreenHeader(title: "Today's Program")
                .padding(10)

            ScrollView {
                VStack(spacing: 24) {
                    ForEach(program.workouts) { workout in
                        // Bind each row's checkbox to membership in the set.
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

                    // Save, then push the "Great Job" screen. On failure the
                    // user stays here with an error card so they can retry.
                    Button {
                        if submitProgram() {
                            navigation.exercisePath.append(ExerciseFlow.completed)
                        } else {
                            presentError(.saveFailed(.workout))
                        }
                    } label: {
                        PrimaryButtonLabel(title: "Submit")
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

    /// Saves which workouts were ticked so the calendar can mark the day.
    /// Returns false if the save failed; the pending insert is rolled back
    /// so a retry doesn't create a duplicate record.
    private func submitProgram() -> Bool {
        let names = program.workouts
            .filter { completedWorkoutIDs.contains($0.id) }
            .map(\.name)
        modelContext.insert(CompletedProgram(program: program, completedWorkouts: names))
        do {
            try modelContext.save()
            return true
        } catch {
            Self.logger.error("Failed to save completed program for day \(program.day): \(error.localizedDescription)")
            modelContext.rollback()
            return false
        }
    }
}

#Preview {
    NavigationStack {
        ActiveInProgramView(program: ExerciseMockData().programs[1])
    }
    .errorCardHost()
    .modelContainer(for: CompletedProgram.self, inMemory: true)
    .environmentObject(AppNavigationViewModel())
}
