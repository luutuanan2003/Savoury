import SwiftUI

struct TimerTView: View {
    @Binding var isTimerViewVisible: Bool
    @State var currentAngle: Angle = .degrees(0)
    @State var finalAngle: Angle = .degrees(0)
    @State private var timeRemaining: Int = 0
    @State private var isTimerRunning: Bool = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    let minRotation: Angle = .degrees(0)
    let maxRotation: Angle = .degrees(360) // Equivalent to 60 in your radial layout

    func startTimer() {
        isTimerRunning = true
    }

    func resetTimer() {
        isTimerRunning = false
        timeRemaining = 0
    }

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        isTimerViewVisible = false
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .background(Circle().fill(Color.yellow).shadow(radius: 4))
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

                    VStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 8, height: 25)
                            .cornerRadius(4.0)
                        Spacer()
                    }
                    .frame(height: 140)
                    .rotationEffect(currentAngle + finalAngle)
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                let newAngle = currentAngle + angle
                                if newAngle < minRotation {
                                    currentAngle = minRotation
                                } else if newAngle > maxRotation {
                                    currentAngle = maxRotation
                                } else {
                                    currentAngle = newAngle
                                }
                            }
                            .onEnded { angle in
                                let newFinalAngle = finalAngle + angle
                                if newFinalAngle < minRotation {
                                    finalAngle = minRotation
                                } else if newFinalAngle > maxRotation {
                                    finalAngle = maxRotation
                                } else {
                                    finalAngle = newFinalAngle
                                }
                                currentAngle = .degrees(0)
                            }
                    )
                }

                Spacer()

                VStack {
//                    TimeSelection(selectedTimeUnit:)
                    Spacer()

                    HStack {
                        Button(action: {
                            resetTimer()
                        }) {
                            Text("Reset")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Capsule().fill(Color.yellow).shadow(radius: 4))
                        }
                        Spacer()
                        Button(action: {
                            startTimer()
                        }) {
                            Text("Start")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Capsule().fill(Color.yellow).shadow(radius: 4))
                        }
                    }
                }
                .frame(width: 320)
            }
            .padding()
        }
    }
}


//struct RadialLayout: Layout {
//    func sizeThatFits(
//        proposal: ProposedViewSize,
//        subviews: Subviews,
//        cache: inout ()) -> CGSize {
//            proposal.replacingUnspecifiedDimensions()
//    }
//    
//    func placeSubviews(
//        in bounds: CGRect,
//        proposal: ProposedViewSize,
//        subviews: Subviews,
//        cache: inout ()) {
//        
//        let radius = bounds.width / 2.5 // Adjust radius to fit design better
//        let angle = Angle.degrees(360.0 / Double(subviews.count)).radians
//        
//        for (index, subview) in subviews.enumerated() {
//            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle * Double(index)))
//            point.x += bounds.midX
//            point.y += bounds.midY
//            
//            subview.place(at: point, anchor: .center, proposal: .unspecified)
//        }
//    }
//}

#Preview {
    TimerTView(isTimerViewVisible: .constant(false))
}
