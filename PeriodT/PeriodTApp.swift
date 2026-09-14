//
//  PeriodTApp.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI
import SwiftData

@main
struct PeriodTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PollAnswers.self)
    }
}
