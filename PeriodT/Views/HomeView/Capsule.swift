//
//  Capsule.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct Capsule: View {
    var upperText: String
    var lowerText: String
    var systemimage: String
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(upperText)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Image(systemName: systemimage)
            
            Divider()
                .frame(minHeight: 2)
                .background(CoreColor.secondary)
            
            Text(lowerText)
                .font(.system(size: 15, weight: .bold, design: .rounded))
        }
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(CoreColor.secondary, lineWidth: 2) // Sets the color and thickness
        )
        .padding()
    }
}

#Preview {
    Capsule(upperText: "hellow", lowerText: "your period is coming", systemimage: "cloud.sun.fill")
    Capsule(upperText: "goodbye", lowerText: "its gone", systemimage: "book")
}


