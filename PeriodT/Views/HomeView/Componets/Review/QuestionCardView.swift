//
//  QuestionCardView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

import SwiftUI

struct QuestionCardView: View {
    let id = UUID()
    var upperText: String
    var color: Color


    var body: some View {
        VStack(spacing: 0) {
            
        
            Text(upperText)
                .font(.system(size: 16))
                .foregroundColor(CoreColor.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 40)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .background(color)
            
            // pink Yes/No footer
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.15), radius: 10, y: 6)
    }
}

#Preview {
    QuestionCardView(upperText: "Were you on your period?", color: CoreColor.primary)
}
