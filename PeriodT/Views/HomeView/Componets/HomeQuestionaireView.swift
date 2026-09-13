//
//  QuickQuestionaireView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 13/9/2026.
//

//TODO: REVIEW IN THE MORNING
//import SwiftUI
//
//struct HomeQuestionaireView: View {
//    @StateObject private var viewModel = PollViewModel()
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text("Review")
//                .font(.system(size: 30, weight: .heavy, design: .rounded))
//                .foregroundColor(CoreColor.primary)
//
//            ForEach(viewModel.questions) { question in
//                QuestionCardView(
//                    question: question.text,
//                    color: question.color,
//                    selectedAnswer: Binding(
//                        get: { viewModel.answer(for: question) },
//                        set: { newValue in
//                            if let newValue { viewModel.setAnswer(newValue, for: question) }
//                        }
//                        
//                    )
//                )
//            }
//        }
//    }
//}
//
//#Preview {
//    HomeQuestionaireView()
//}
//
