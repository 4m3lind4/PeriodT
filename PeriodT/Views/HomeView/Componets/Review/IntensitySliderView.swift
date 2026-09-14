//
//  IntensitySliderView.swift
//  PeriodT
//
//  Created by Jessica Amelinda Mang on 14/9/2026.
//

import SwiftUI

/// Five-step "how pleasant" slider, from very unpleasant (0) to very pleasant (4).
struct IntensitySliderView: View {
    static let steps = 5

    @State var selectedIntensity: Int = 2

    private let trackHeight: CGFloat = 20
    private let thumbSize: CGFloat = 30

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Emotional Intensity")
                .font(Font.system(size: 20, design: .rounded))
                .foregroundColor(CoreColor.primary)

            GeometryReader { geo in
                let stepWidth = geo.size.width / CGFloat(Self.steps)
                let thumbX = stepWidth * (CGFloat(selectedIntensity) + 0.5)

                ZStack(alignment: .leading) {
                    SwiftUI.Capsule()
                        .fill(CoreColor.ringBackground)
                        .frame(height: trackHeight)
                        .shadow(color: .black.opacity(0.15), radius: 0, y: 3)

                    HStack(spacing: 0) {
                        ForEach(0..<Self.steps, id: \.self) { _ in
                            Circle()
                                .fill(CoreColor.primary)
                                .frame(width: 10, height: 10)
                                .frame(maxWidth: .infinity)
                        }
                    }

                    Circle()
                        .fill(CoreColor.primary)
                        .frame(width: thumbSize, height: thumbSize)
                        .position(x: thumbX, y: geo.size.height / 2)
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let index = Int(value.location.x / stepWidth)
                            selectedIntensity = min(max(index, 0), Self.steps - 1)
                        }
                )
                .animation(.snappy(duration: 0.2), value: selectedIntensity)
            }
            .frame(height: thumbSize)

            HStack {
                Text("VERY UNPLEASANT")
                Spacer()
                Text("VERY PLEASANT")
            }
            .font(Font.system(size: 16, design: .rounded))
            .foregroundColor(CoreColor.primary)
        }
    }
}

#Preview {
    IntensitySliderView()
        .padding()
}
