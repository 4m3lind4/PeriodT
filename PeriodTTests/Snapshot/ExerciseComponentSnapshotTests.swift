//
//  ExerciseComponentSnapshotTests.swift
//  PeriodTTests
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import PeriodT

/// Snapshots for the leaf components on the Exercise tab.
final class ExerciseComponentSnapshotTests: SnapshotTestCase {

    func testWorkoutRowWithSets() {
        assertViewSnapshot(
            of: WorkoutRow(workout: Workout(name: "Bench Press", sets: 10)).padding(),
            width: 360, height: 80
        )
    }

    func testWorkoutRowWithoutSets() {
        assertViewSnapshot(
            of: WorkoutRow(workout: Workout(name: "Press-V BD Shoulder Press (Standing)")).padding(),
            width: 360, height: 80
        )
    }

    func testWorkoutChecklistRowUnchecked() {
        assertViewSnapshot(
            of: WorkoutChecklistRow(
                workout: Workout(name: "Banded Pull up", sets: 6),
                isChecked: .constant(false)
            ).padding(),
            width: 360, height: 80
        )
    }

    func testWorkoutChecklistRowChecked() {
        assertViewSnapshot(
            of: WorkoutChecklistRow(
                workout: Workout(name: "Banded Pull up", sets: 6),
                isChecked: .constant(true)
            ).padding(),
            width: 360, height: 80
        )
    }
}
