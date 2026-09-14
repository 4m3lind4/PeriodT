//
//  ContentView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

/// Root of the app: a three-tab layout (Home, Calendar, Exercise).
/// Tab selection and the exercise navigation stack live in `AppNavigationViewModel`
/// so deep screens (e.g. the completed-program page) can jump back home.
struct ContentView: View {
    /// Shown on launch when the data store failed to open (see `AppModelContainer`).
    var loadError: AppError? = nil

    let exerciseData = ExerciseMockData()
    @StateObject private var navigation = AppNavigationViewModel()

    var body: some View {
        TabView(selection: $navigation.selectedTab) {
            PeriodTHome(exerciseData: exerciseData)
                .errorCardHost()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Home")
                }
                .tag(AppNavigationViewModel.Tab.home)
            PeriodTTracking()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(AppNavigationViewModel.Tab.calendar)

            // Exercise tab owns a NavigationStack so cards can push
            // the in-progress screen, then the completed screen.
            NavigationStack(path: $navigation.exercisePath) {
                PeriodTExercises(exerciseData: exerciseData)
                    .navigationDestination(for: ExerciseProgram.self) { program in
                        ActiveInProgramView(program: program)
                    }
                    .navigationDestination(for: ExerciseFlow.self) { step in
                        switch step {
                        case .completed:
                            CompletedProgramView()
                        }
                    }
            }
                .errorCardHost()
                .tabItem {
                    Image(systemName: "figure.flexibility")
                    Text("Exercise")
                    
                }
                .tag(AppNavigationViewModel.Tab.exercise)
                }
        .tint(CoreColor.primary)
        // Share navigation state with every screen in the tab tree.
        .environmentObject(navigation)
        // Store-load failure is app-wide, so it sits above the tab bar.
        .errorCardHost(initial: loadError)



    }
}

#Preview {
    ContentView()
}
