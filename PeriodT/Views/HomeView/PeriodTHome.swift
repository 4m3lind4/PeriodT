//
//  PeriodTHome.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct PeriodTHome: View {
    var body: some View {
        UpcomingEventCapsule( title: "National Team Selection", daysRemaining: 45)
        CycleRingView()
        Capsule(upperText: "Upcoming Event", lowerText: "Nationals Team Selection", systemimage: nil ,type: .withoutImage)
        
    }
}



#Preview {
    PeriodTHome()
}
