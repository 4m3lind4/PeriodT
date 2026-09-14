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
    // SwiftData store for daily poll answers and submitted programs.
    // If the on-disk store can't be opened we run in memory and tell the user.
    private let store = AppModelContainer.make()

    var body: some Scene {
        WindowGroup {
            ContentView(loadError: store.loadError)
        }
        .modelContainer(store.container)
    }
}
