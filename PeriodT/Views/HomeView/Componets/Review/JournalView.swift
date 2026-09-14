//
//  JournalView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

struct JournalView: View {
    @State var notes: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Journal")
                .font(Font.system(size: 20, design: .rounded))
                .foregroundColor(CoreColor.primary)
            
            ZStack(alignment: .topLeading) {
                if notes.isEmpty {
                    Text("Type your notes here...")
                        .foregroundColor(CoreColor.primary)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 8)
                        .zIndex(1)
                }
                
                TextEditor(text: $notes)
                    .scrollContentBackground(.hidden)
                    .background(CoreColor.ringBackground)
                    .cornerRadius(8)
                    .foregroundStyle(CoreColor.primary)
            }
            .frame(height: 150)
        }
    }
}

#Preview {
    JournalView()
}
