//
//  TabBarView.swift
//  Savoury
//
//  Created by Elwiz Scott on 27/8/24.
//

import SwiftUI

struct TabBarView: View {
    @Binding var showSelectionScreen: Bool
    @Binding var showTimerScreen: Bool
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        if tab == .camera {
                            showSelectionScreen = true
                        } else if tab == .timer {
                            showTimerScreen = true
                        } else {
                            selectedTab = tab
                        }
                    }) {
                        Image(systemName: tab.iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .padding()
                            .background(
                                Circle()
                                    .fill(selectedTab == tab ? Color.yellow : Color.clear)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 0)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray)
                    .opacity(0.1)
                    .frame(height: 60)
                    .padding(.horizontal, 20)
            )
            .padding(.bottom, -10)
        }
    }
}



enum Tab: String, CaseIterable {
    case home
    case bookmark
    case camera
    case cooking
    case timer

    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .bookmark:
            return "bookmark"
        case .camera:
            return "camera"
        case .cooking:
            return "frying.pan"
        case .timer:
            return "timer"
        }
    }
}


struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(showSelectionScreen: .constant(false),
                   showTimerScreen: .constant(false))
    }
}
