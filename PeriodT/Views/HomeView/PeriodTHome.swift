//
//  PeriodTHome.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct PeriodTHome: View {
    var body: some View {
        Capsule(upperText: "hellow", lowerText: "your period is coming", systemimage: "cloud.sun.fill",type: .withImage)

        CycleRingView()
        
        Capsule(upperText: "Test remove image", lowerText: "its gone", systemimage: "book",type: .withoutImage)
        
    }
}



#Preview {
    PeriodTHome()
}
