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

struct ProgressBar: View {
    @Binding var progress: Float
    private let strokeWidth: CGFloat = 32.0
    private let startDegrees: Double = 270.0

    
    func endPosition(for angle: Double, in size: CGSize) -> CGPoint {
        let radius = (min(size.width, size.height) / 2) - (strokeWidth / 2) + 16
        let radians = angle * .pi / 180
        return CGPoint(
            x: size.width / 2 + radius * CGFloat(cos(radians)),
            y: size.height / 2 + radius * CGFloat(sin(radians))
        )
    }
    
    var body: some View{
        
        GeometryReader{ geometry in
            let size = geometry.size
            let startAngle = startDegrees - 360
            let endAngle = startAngle + Double(progress) * 360.0
            let preStartAngle = startAngle - 80

            let startPos    = endPosition(for: startAngle, in: size)
            let endPos      = endPosition(for: endAngle, in: size)
            let preStartPos = endPosition(for: preStartAngle, in: size)


            ZStack {
                Circle()
                    .stroke(
                        CoreColor.ringBackground,
                        lineWidth: 40.0
                    )
                
                    .opacity(0.20)
                //Period Animation
                Circle()
                    .trim(
                        from: 0.0,
                        to: CGFloat(min(self.progress, 1.0))
                    )
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                CoreColor.primary,
                                CoreColor.ringBackground
                                
                                
                            ]),
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: 32.0,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .rotationEffect(.degrees(startDegrees))
                    .animation(
                        .easeInOut(duration: 2.0),
                        value: progress
                    )
                
                
                //PERIOD DEADLINE
                Circle()
                    .fill(CoreColor.primary)
                    .frame(width: strokeWidth, height: strokeWidth)
                    .overlay(
                        Image(systemName: "drop.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
//                            .position(endPos)
                )
                    .position(startPos)
                //USER CIRCLE
                Circle()
                    .fill(CoreColor.ringBackground)
                    .stroke(CoreColor.ringBackground, lineWidth: 2.5)
                    .frame(width: strokeWidth, height: strokeWidth)
                    .overlay(
                        Image(systemName: "face.smiling.inverse")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(CoreColor.secondary)
                )
                    .position(endPos)
                
                // Navigation Button
//MARK: REMOVE
                NavigationLink(destination: EmptyView()) {
                    Circle()
                        .fill(.clear)
                        .frame(width: strokeWidth, height: strokeWidth)
//                        .overlay(
//                            Image(systemName: "chevron.right")
//                                .font(.system(size: 10, weight: .bold))
//                                .foregroundColor(.white)
//                        )
                }
                .position(preStartPos)
                //Internal Text
                VStack{
                    Text("Period in")
                        .font(.title3)
                    // Number of days remaining
                    Text("7")
                        .font(.largeTitle)
                        .bold()

                    Text("Days")
                        .font(.title3)
                    
                    
                    
                    Text("Luteral Phase")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 42)
                        .background(
                            RoundedRectangle(cornerRadius: 15)                               .fill(CoreColor.secondary)
                        )
                        .padding(.top, 1)
                        
                }
                .foregroundStyle(Color(CoreColor.primary))

            }
        }
        
    }
    struct CycleInsightView_Previews: PreviewProvider {
        static var previews: some View {
            CycleRingView()
        }
    }
}
#Preview {
    CycleRingView()
}
