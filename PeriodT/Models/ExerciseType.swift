//
//  ExerciseType.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation

enum ExerciseType {
    case physio
    case conditioningTraining
    
}

extension ExerciseType {
    var title: String {
        
        switch self {
            
        case .physio:
            return "Physio"

        case .conditioningTraining:
            return "Conditioning"
        }
    }
}
