//
//  TimerView.swift
//  Savoury
//
//  Created by Elwiz Scott on 29/8/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var isTimerViewVisible: Bool
    @State private var timeRemaining: Int = 0
    @State private var isTimerRunning: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.yellow)
                .frame(width: 360, height: 304)
            
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: 100, height: 100)
                        .background(Circle().fill(Color.yellow))
                        .shadow(radius: 5)
                    
                    RadialLayout {
                        ForEach(0..<7, id: \.self) { index in
                            VStack {
                                Text("\(index * 10)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                             // Adjusts the spacing from the center
                        }
                    }
                    .frame(width: 200, height: 200)
                    
                    
                    
                    
                    // Timer needle
                    VStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 4, height: 20)
                        Spacer()
                    }
                    .frame(height: 100)
                }
                
                
                
                HStack {
                    Text(timeString(from: timeRemaining))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        isTimerRunning.toggle()
                        startTimer()
                        isTimerViewVisible = false
                    }) {
                        Text("Start")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                            .background(Capsule().fill(Color.white))
                            .overlay(
                                Capsule()
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
                .padding([.horizontal], 20)
            }
            .padding()
        }
        .frame(width: 350, height: 350)  // Ensure the entire content is within the yellow box
        .padding(.top, 50)
    }
    
    // Helper function to format the time
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Placeholder function for starting the timer
    func startTimer() {
        // Implement timer logic here
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(isTimerViewVisible: .constant(true)) // Pass a constant binding for preview
    }
}





struct RadialLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()) -> CGSize {
            proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()) {
        
        let radius = bounds.width / 2.5 // Adjusted radius to fit the design better
        let angle = Angle.degrees(315.0 / Double(subviews.count)).radians
        
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle * Double(index)))
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

