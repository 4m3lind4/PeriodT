//
//  CompletedProgramView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

/// Post-workout screen: intensity rating, journal, and a coach prompt.
/// Submitting plays a confetti celebration, then pops the whole exercise
/// stack and returns to Home.
struct CompletedProgramView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel

    @State private var informCoach: ReviewAnswer?
    @State private var showCelebration = false

    var body: some View {
        ZStack{
            CoreColor.primary
                .ignoresSafeArea()
            ScrollView {
            VStack(alignment: .leading, spacing: 16){
                Text("Great Job!")
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                PostWorkoutIntensity()
                WorkoutJournalView()

                QuestionCardView(
                    selectedAnswer: $informCoach,
                    question: "Would you like to inform your coach about your set?",
                    color: CoreColor.accent
                )
                .padding(.horizontal, 8)

                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showCelebration = true
                    }
                } label: {
                    PrimaryButtonLabel(title: "Submit")
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            }
            .padding(10)
            }

            if showCelebration {
                WorkoutCelebrationView {
                    navigation.returnHome()
                }
                .zIndex(1)
            }
        }
        .toolbar(showCelebration ? .hidden : .visible, for: .navigationBar)
    }
}

#Preview {
    CompletedProgramView()
        .environmentObject(AppNavigationViewModel())
}
