//
//  HomeComponentSnapshotTests.swift
//  PeriodTTests
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import PeriodT

/// Snapshots for the leaf components on the Home tab.
final class HomeComponentSnapshotTests: SnapshotTestCase {

    // MARK: Header

    func testUpcomingEventCapsule() {
        assertViewSnapshot(
            of: UpcomingEventCapsule(title: "State Championships", daysRemaining: 45).padding(),
            width: 360, height: 100
        )
    }

    func testUpcomingEventCapsuleLongTitle() {
        assertViewSnapshot(
            of: UpcomingEventCapsule(
                title: "A really long event name that could wrap onto another line",
                daysRemaining: 3
            ).padding(),
            width: 360, height: 140
        )
    }

    // MARK: Programs

    func testProgramCardUpcoming() {
        // `program.color` currently compares day-of-month only, so use the 31st:
        // it is >= today's day number on every day of the year → primary pink.
        let program = TestHelpers.makeProgram(
            date: TestHelpers.date(2026, 10, 31), day: 1, duration: 60, type: .conditioningTraining
        )
        assertViewSnapshot(of: ProgramCard(program: program).padding(), width: 360, height: 220)
    }

    func testProgramCardPast() {
        // Day 1 is < today's day number except on the 1st of a month, so this
        // renders lavender (see note in testProgramCardUpcoming).
        let program = TestHelpers.makeProgram(
            date: TestHelpers.date(2026, 9, 1), day: 2, duration: 45, type: .physio
        )
        assertViewSnapshot(of: ProgramCard(program: program).padding(), width: 360, height: 220)
    }

    // MARK: Review

    func testQuestionCardUnanswered() {
        assertViewSnapshot(
            of: QuestionCardView(
                selectedAnswer: .constant(nil),
                question: "Did you practice or train today?",
                color: CoreColor.secondary
            ).padding(),
            width: 360, height: 240
        )
    }

    func testQuestionCardAnsweredYes() {
        assertViewSnapshot(
            of: QuestionCardView(
                selectedAnswer: .constant(.yes),
                question: "Were you on your period?",
                color: CoreColor.secondary
            ).padding(),
            width: 360, height: 240
        )
    }

    func testQuestionCardAnsweredNo() {
        assertViewSnapshot(
            of: QuestionCardView(
                selectedAnswer: .constant(.no),
                question: "Would you like to inform your coach about your period?",
                color: CoreColor.primary
            ).padding(),
            width: 360, height: 260
        )
    }

    func testEmotionButtonSelectedAndUnselected() {
        let row = HStack(spacing: 16) {
            EmotionButton(emotion: .happy, selectedEmotion: .constant(.happy))
            EmotionButton(emotion: .sad, selectedEmotion: .constant(.happy))
        }.padding()
        assertViewSnapshot(of: row, width: 300, height: 140)
    }

    func testAllEmotionButtonsUnselected() {
        let row = HStack(spacing: 8) {
            ForEach(Emotion.allCases) { emotion in
                EmotionButton(emotion: emotion, selectedEmotion: .constant(nil))
            }
        }.padding()
        assertViewSnapshot(of: row, width: 400, height: 140)
    }

    func testIntensitySlider() {
        assertViewSnapshot(of: IntensitySliderView(selectedIntensity: .constant(2)).padding(), width: 360, height: 180)
    }

    // MARK: Progress

    func testGoalProgressBar() {
        assertViewSnapshot(of: GoalProgressBar().padding(), width: 360, height: 120)
    }

    func testCycleProgressRingHalfway() {
        assertViewSnapshot(
            of: CycleProgressRing(progress: .constant(0.5)).frame(width: 260, height: 260).padding(40),
            width: 340, height: 340
        )
    }

    func testCycleProgressRingEmpty() {
        assertViewSnapshot(
            of: CycleProgressRing(progress: .constant(0.0)).frame(width: 260, height: 260).padding(40),
            width: 340, height: 340
        )
    }

    // MARK: Forecast

    func testForecastChart() {
        assertViewSnapshot(of: ChartView().padding(), width: 360, height: 300)
    }
}
