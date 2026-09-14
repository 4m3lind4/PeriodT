//
//  Emotion.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import Foundation
import SwiftUI

enum Emotion: CaseIterable, Identifiable {
    case happy
    case calm
    case neutral
    case sad
    case stressed

    var id: Self { self }
}

extension Emotion {
    var image: ImageResource {
        
        switch self {
        case .happy:
            return .faceHappy
        case .calm:
            return .faceContent
        case .neutral:
            return .faceNeutral
        case .sad:
            return .faceFrown
        case .stressed:
            return .faceSad
        }
    }
    
}
