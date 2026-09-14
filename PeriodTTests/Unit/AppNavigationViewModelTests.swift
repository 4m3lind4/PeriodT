//
//  AppNavigationViewModelTests.swift
//  PeriodTTests
//

import Testing
import SwiftUI
@testable import PeriodT

@Suite("AppNavigationViewModel")
@MainActor
struct AppNavigationViewModelTests {

    @Test func defaultsToHomeWithEmptyPath() {
        let nav = AppNavigationViewModel()
        #expect(nav.selectedTab == .home)
        #expect(nav.exercisePath.isEmpty)
    }

    @Test func returnHomeClearsPathAndSwitchesTab() {
        let nav = AppNavigationViewModel()
        nav.selectedTab = .exercise
        nav.exercisePath.append(ExerciseFlow.completed)
        nav.exercisePath.append(ExerciseFlow.completed)
        #expect(nav.exercisePath.count == 2)

        nav.returnHome()

        #expect(nav.selectedTab == .home)
        #expect(nav.exercisePath.isEmpty)
    }

    @Test func tabRawValuesMatchTabOrder() {
        #expect(AppNavigationViewModel.Tab.home.rawValue == 0)
        #expect(AppNavigationViewModel.Tab.calendar.rawValue == 1)
        #expect(AppNavigationViewModel.Tab.exercise.rawValue == 2)
    }
}
