//
//  ExerciseMockData.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

/// Hard-coded programs used in place of a coach backend for the assignment.
struct ExerciseMockData {
    let programs = [
        ExerciseProgram(
            date: Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 12)) ?? Date(),
            day: 1,
            exerciseDuration: 60,
            numberOfExercises: 6,
            exerciseType: .conditioningTraining,
            workouts: [Workout(name: "Squat", sets: 10), Workout(name: "Bench Press", sets: 10)]
            
        ),
        ExerciseProgram(
            date: Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 15)) ?? Date(),
            day: 2,
            exerciseDuration: 45,
            numberOfExercises: 5,
            exerciseType: .physio,
            workouts: [Workout(name: "Banded Pull up", sets: 6), Workout(name: "Chest Fly", sets: 10), Workout(name: "Press-V BD Shoulder Press (Standing)")]
        )
    ]
}
