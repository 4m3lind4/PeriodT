//
//  QuestionCardView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI


enum ReviewAnswer: Equatable {
    case yes
    case no
}


struct QuestionCardView: View {
    @State private var selectedAnswer: ReviewAnswer? = nil
    let id = UUID()
    var question: String
    var color: Color
    var onYes: () -> Void
    var onNo: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text(question)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 40)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .background(color)
            
            HStack(spacing: 0) {
                Button {
                    selectedAnswer = .yes
                    onYes()
                } label: {
                    Text("Yes")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(CoreColor.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(selectedAnswer == .yes ? Color.orange.opacity(0.3) : Color.clear)
                }

                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 1)

                Button {
                    selectedAnswer = .no
                    onNo()
                } label: {
                    Text("No")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(CoreColor.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(selectedAnswer == .no ? Color.orange.opacity(0.3) : Color.clear)
                }
            }
            .background(Color.pink.opacity(0.08))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .shadow(color: .black.opacity(0.15), radius: 10, y: 6)
    }
    
}


#Preview {
    QuestionCardView(
        question: "Did you practice or train today?", color: CoreColor.primary, onYes: { print("Yes tapped") }, onNo: { print("No tapped") }
    )
}
