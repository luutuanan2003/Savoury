//
//  TimeSelectionView.swift
//  Savoury
//
//  Created by Elwiz Scott on 1/9/24.
//

import SwiftUI

// A SwiftUI view representing a custom hour min sec bar for the application.

struct TimeSelection: View {
    @State private var selectedTimeUnit: TimeUnit = .hour

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TimeUnit.allCases, id: \.self) { unit in
                Button(action: {
                    selectedTimeUnit = unit
                }) {
                    Text(unit.rawValue.uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(selectedTimeUnit == unit ? Color.white : Color.yellow)
                                .padding(.horizontal, 3)
                        )
                }
            }
        }
        .frame(height: 60)
        .background(
            Capsule()
                .fill(Color.yellow)
                .shadow(radius: 4)
        )
        .padding(.top, 40)
    }
}

enum TimeUnit: String, CaseIterable {
    case hour = "Hour"
    case min = "Min"
    case sec = "Sec"
}


#Preview {
    TimeSelection()
}
