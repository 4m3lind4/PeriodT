//
//  Capsule.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI
enum CapsuleType{
    case withImage
    case withoutImage
}

struct Capsule: View {
    var upperText: String
    var lowerText: String
    var systemimage: String?
    var type: CapsuleType
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(upperText)
                .padding(1)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            if type == .withImage{
                let systemimage = systemimage!
                Image(systemName: systemimage)
                    .foregroundStyle(Color.secondary)
            }
            
            Divider()
                .frame(minHeight: 2)
                .background(CoreColor.secondary)
            
            Text(lowerText)
                .font(.system(size: 15, weight: .bold, design: .rounded))
        }
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(CoreColor.secondary, lineWidth: 2)
        )
        .padding()
    }
}

#Preview {
    Capsule(upperText: "Upcoming Event", lowerText: "Nationals Team Selection", systemimage: nil ,type: .withoutImage)
}


