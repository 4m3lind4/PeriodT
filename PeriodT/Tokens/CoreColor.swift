//
//  Colors.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 11/9/2026.
//

import Foundation
import SwiftUI

public final class CoreColor {
    
    // MARK: - Primary Brand Colours
    
    static var primary: Color = Color(hex: "#D96F94")
    
    static var secondary: Color = Color(hex: "#A875A6")
    
    // MARK: - Background Colours
    
    static var ringBackground: Color = Color(hex: "#FFEBF2")
    
    static var lavender: Color = Color(hex: "#DEC6E8")
    
    // MARK: - Accent Colours
    
    static var accent: Color = Color(hex: "#EE7D56")
    
    static var white: Color = Color(hex: "#FFFFFF")
}
// MARK: - Hex Colour Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let red = Double((int >> 16) & 0xFF) / 255
        let green = Double((int >> 8) & 0xFF) / 255
        let blue = Double(int & 0xFF) / 255
        
        self.init(
            red: red,
            green: green,
            blue: blue
        )
    }
}
