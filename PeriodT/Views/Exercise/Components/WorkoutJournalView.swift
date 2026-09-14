//
//  WorkoutJournalView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

/// Journal styled for the pink completed-program screen.
struct WorkoutJournalView: View {
    @State var notes: String = ""

    var body: some View {
        JournalTextEditor(
            title: "Workout Journal",
            titleColor: CoreColor.ringBackground,
            notes: $notes
        )
    }
}

#Preview {
    WorkoutJournalView()
        .padding()
        .background(CoreColor.primary)
}
