//
//  CycleRingView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import SwiftUI

struct CycleRingView: View {
    @State var progressValue: Float = 0.0
    var body: some View {
        VStack{
            ProgressBar(progress: self.$progressValue)
                .frame(width: 260.0, height: 260)
                .padding(20.0).onAppear(){
                    self.progressValue = 0.30
                }
        }
    }
}


#Preview {
    CycleRingView()
}
