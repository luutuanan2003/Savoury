//
//  TimerScreen.swift
//  Savoury
//
//  Created by Elwiz Scott on 29/8/24.
//

import SwiftUI

// This view make use of the custom layout provided in the lectorial code example in example 9, week 4 to resemble the twist timer appears in most of the kitchen ware.

struct TimerScreen: View {
    @Binding var isTimerViewVisible: Bool
//    @State private var timeRemaining: Int = 0
//    @State private var isTimerRunning: Bool = false
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)  // White background to cover the entire screen
            VStack(spacing: 0) {
                // Top navigation bar
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .background(Circle()
                                .fill(Color.yellow)
                                .shadow(radius: 4))
                    }
                    Spacer()
                }
                
                Text("00:00:00")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .padding(30)

                
                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 3)
                        .frame(width: 160, height: 160)
                        .background(Circle().fill(Color.yellow))
                        .shadow(radius: 5)
                    
                    RadialLayout {
                        ForEach(0..<7, id: \.self) { index in
                            VStack {
                                Text("\(index * 10)")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                             // Adjusts the spacing from the center
                        }
                    }
                    .frame(width: 340, height: 280)
                    .padding(.top, 10)
                    
                    RadialLayout {
                        ForEach(0..<7, id: \.self) {_ in
                            Circle()
                                .frame(width: 9, height: 10)
                                .shadow(radius: 5)
                        }
                    }
                    .frame(width: 260)
                    
                    // Timer needle
                    VStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 8, height: 25)
                            .cornerRadius(4.0)
                        Spacer()
                    }
                    .frame(height: 140)
                }
                
                Spacer()
                
                VStack {
                    HStack(spacing: 0) {
                        Capsule()
                            .fill(Color.yellow)
                            .frame(width: .infinity, height: 60)
                            .shadow(radius: 4)
                            .overlay(
                                HStack(spacing: 0) {
                                    Text("HOUR")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Capsule().fill(Color.white)
                                            .frame(width: 100))
                                    
                                    Text("MIN")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                    
                                    Text("SEC")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.horizontal, 10)
                            )
                    }
                    
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Reset and Start buttons
                    HStack {
                        Text("Reset")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                        
                            .background(Capsule()
                                .fill(Color.yellow)
                                .frame(height: 50)
                                .shadow(radius: 4))
                                                    
                        Spacer()
                        
                        Text("Start")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Capsule()
                                .fill(Color.yellow)
                                .frame(height: 50)
                                .shadow(radius: 4))
                    }
                }
                .frame(width: 320)
            }
            .padding()
        }
        
    }
}


struct TimerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TimerScreen(isTimerViewVisible: .constant(true))
    }
}

// MARK: Modified RadialLayout
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

