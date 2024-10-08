//
//  CustomGestureView.swift
//  Savoury
//
//  Created by Elwiz Scott on 7/10/24.
//

import SwiftUI

struct CustomGestureView: View {
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(0)
    @State private var timeRemaining: Int = 0
    @State private var isLocked: Bool = false

    @GestureState private var isLongPressed = false
    
    var body: some View {
        ZStack {
            // Circular Timer Interface
            Circle()
                .strokeBorder(Color.black, lineWidth: 3)
                .frame(width: 200, height: 200)
                .overlay(
                    VStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 8, height: 40)
                            .cornerRadius(4)
                        Spacer()
                    }
                    .frame(height: 100)
                    .rotationEffect(currentAngle + finalAngle)
                )
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .sequenced(before: RotationGesture())
                        .updating($isLongPressed) { value, state, _ in
                            if case .first(true) = value {
                                state = true  // Set state to true once long press is activated
                            }
                        }
                        .onChanged { value in
                            if case .second(true, let angle) = value {
                                currentAngle = angle ?? .degrees(0) // Provide a default value if nil
                                timeRemaining = convertRotationToSeconds(currentAngle)
                            }
                        }
                        .onEnded { value in
                            if case .second(true, let angle) = value {
                                finalAngle += angle ?? .degrees(0) // Provide a default value if nil
                                currentAngle = .degrees(0)
                            }
                        }
                )
                .overlay(
                    Text(isLongPressed ? "Pressing" : "Not Pressing")
                        .foregroundColor(.red)
                        .bold()
                        .offset(y: -150)
                )
        }
    }

    /// Helper to convert angle to seconds
    func convertRotationToSeconds(_ angle: Angle) -> Int {
        let rotationDegrees = angle.degrees.truncatingRemainder(dividingBy: 360)
        return Int(rotationDegrees / 360 * 60)
    }
}

struct CustomGestureView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGestureView()
    }
}
