//
//  AppNavigationViewModel.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import Combine
import SwiftUI

/// App-wide navigation state so deep screens can pop back and switch tabs.
final class AppNavigationViewModel: ObservableObject {
    enum Tab: Int {
        case home, calendar, exercise
    }

    @Published var selectedTab: Tab = .home
    @Published var exercisePath = NavigationPath()

    /// Clears the exercise stack and returns to the Home tab.
    func returnHome() {
        exercisePath = NavigationPath()
        selectedTab = .home
    }
}
