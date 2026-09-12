//
//  ProgramViews.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 12/9/2026.
//

import SwiftUI

struct ProgramViews: View {
    var Date: String
    var Day: Int
    var ExerciseDuration: String
    var NumOFExercise: Int
    
    var body: some View {
        ScrollView{
            Rectangle()
        }
    }
}

#Preview {
    ProgramViews(Date: "MON 7", Day: 1, ExerciseDuration: "60", NumOFExercise: 6)
}
