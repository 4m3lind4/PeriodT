//
//  ContentView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct ContentView: View {
    let exerciseData = ExerciseMockData()
    var body: some View {
        TabView{
            PeriodTHome(exerciseData: exerciseData)
                .tabItem {
                    Image(systemName: "clock")
                    Text("Home")
                }
                .tag(0)
            PeriodTTracking()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(1)

            NavigationStack {
                PeriodTExercises(exerciseData: exerciseData)
            }
                .tabItem {
                    Image(systemName: "figure.flexibility")
                    Text("Exercise")
                    
                }
                .tag(2)
                }
        .tint(CoreColor.primary)



    }
}

#Preview {
    ContentView()
}
