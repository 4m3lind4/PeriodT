//
//  QuestionCardView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI

struct QuestionCardView: View {
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
                Button(action: onYes) {
                    Text("Yes")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(CoreColor.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 28)
                }
                
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 1)
                
                
                Button(action: onNo) {
                    Text("No")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(CoreColor.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        
                }
            }
            .background(Color.pink.opacity(0.08))
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.15), radius: 10, y: 6)
    }
    
}


#Preview {
    QuestionCardView(
        question: "Did you practice or train today?", color: CoreColor.primary, onYes: { print("Yes tapped") }, onNo: { print("No tapped") }
    )
}
