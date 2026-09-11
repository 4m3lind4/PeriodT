//
//  PeriodTHome.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct PeriodTHome: View {
    var body: some View {
        Capsule(upperText: "hellow", lowerText: "your period is coming", systemimage: "cloud.sun.fill")
        CycleRingView()
        Capsule(upperText: "hellow", lowerText: "your period is coming", systemimage: "cloud.sun.fill")
    }
}



#Preview {
    PeriodTHome()
}
