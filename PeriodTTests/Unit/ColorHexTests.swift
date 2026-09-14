//
//  ColorHexTests.swift
//  PeriodTTests
//

import Testing
import SwiftUI
import UIKit
@testable import PeriodT

@Suite("Color(hex:)")
struct ColorHexTests {

    /// Reads the RGB channels back out of a SwiftUI colour (0...1).
    private func rgb(_ color: Color) -> (r: Double, g: Double, b: Double) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(color).getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b))
    }

    private func expectChannels(_ color: Color, _ red: Int, _ green: Int, _ blue: Int) {
        let c = rgb(color)
        #expect(abs(c.r - Double(red) / 255) < 0.01)
        #expect(abs(c.g - Double(green) / 255) < 0.01)
        #expect(abs(c.b - Double(blue) / 255) < 0.01)
    }

    @Test func parsesHashPrefixedHex() {
        expectChannels(Color(hex: "#FF0000"), 255, 0, 0)
        expectChannels(Color(hex: "#00FF00"), 0, 255, 0)
        expectChannels(Color(hex: "#0000FF"), 0, 0, 255)
    }

    @Test func parsesHexWithoutPrefixAndLowercase() {
        expectChannels(Color(hex: "d96f94"), 0xD9, 0x6F, 0x94)
        expectChannels(Color(hex: "D96F94"), 0xD9, 0x6F, 0x94)
    }

    @Test func blackAndWhite() {
        expectChannels(Color(hex: "#000000"), 0, 0, 0)
        expectChannels(Color(hex: "#FFFFFF"), 255, 255, 255)
    }

    @Test func invalidStringFallsBackToBlack() {
        expectChannels(Color(hex: "not a colour"), 0, 0, 0)
        expectChannels(Color(hex: ""), 0, 0, 0)
    }

    @Test func paletteMatchesDesignTokens() {
        expectChannels(CoreColor.primary, 0xD9, 0x6F, 0x94)
        expectChannels(CoreColor.secondary, 0xA8, 0x75, 0xA6)
        expectChannels(CoreColor.ringBackground, 0xFF, 0xEB, 0xF2)
        expectChannels(CoreColor.lavender, 0xDE, 0xC6, 0xE8)
        expectChannels(CoreColor.accent, 0xEE, 0x7D, 0x56)
        expectChannels(CoreColor.yellow, 0xFA, 0xD7, 0x2C)
    }
}
