//
//  QuickQuestionaireView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI

struct HomeQuestionaireView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Review")
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundColor(CoreColor.primary)
                    
            QuestionCardView(
                question: "Did you practice or train today?",
                color: CoreColor.secondary,
                onYes: { print("Yes tapped") },
                onNo: { print("No tapped") }
            )
            
            QuestionCardView(
                question: "Were you on your period?",
                color: CoreColor.primary,
                onYes: { print("Yes tapped") },
                onNo: { print("No tapped") }
            )
            
        }
    }
}

#Preview {
    HomeQuestionaireView()
}

