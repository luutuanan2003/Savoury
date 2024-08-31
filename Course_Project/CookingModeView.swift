//
//  CookingModeView.swift
//  Savoury
//
//  Created by Elwiz Scott on 29/8/24.
//

import SwiftUI

struct CookingModeView: View {
    
    @State private var isTimerViewVisible: Bool = false
    
    var stepIndex: Int = 2 // Current step index
    var totalSteps: Int = 5 // Total steps
    var stepImage: String = "Tteokbokki_s2" // Replace with your image asset name
    var stepDescription: String = "Boil the soup stock in a shallow pot over medium-high heat and dissolve the tteokbokki sauce by stirring it with a spatula. Once the seasoned stock is boiling, add the rice cakes, fish cakes, and onion. Boil them for another 3 to 5 mins until the rice cakes are fully cooked. Then, to thicken the sauce and to deepen the flavor, simmer it over low heat for another 2 to 4 mins."
    var cookingTime: String = "5 MIN"
    
    var body: some View {
        VStack {
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
                Button(action: {
                    // Bookmark action
                }) {
                    Image(systemName: "bookmark")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .shadow(radius: 2))
                        
                }
            }
            .padding([.leading, .trailing])
            .padding(.bottom)
            
            VStack {
                // Step Image
                Image(stepImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 360, height: 240)
                                .cornerRadius(20)
                                
                
                // Step Indicator
                HStack {
                    Spacer()
                    Button(action: {
                                    withAnimation {
                                        isTimerViewVisible.toggle()
                                    }
                                }) {
                                    ZStack {
                                        Capsule()
                                            .fill(Color.yellow)
                                            .frame(width: 100, height: 40)
                                            .padding(.leading)
                                        
                                        HStack(spacing: 10) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 32, height: 32)
                                                
                                                Image(systemName: "clock")
                                                    .foregroundColor(.black)
                                            }
                                            
                                            Text(cookingTime)
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.black)
                                        }
                                        .padding(.horizontal, 16)
                                        
                                    }
                                }
                }
                .padding([.horizontal, .top])
            }
            .overlay(
                ZStack {
                    if isTimerViewVisible {
                                                TimerView(isTimerViewVisible: $isTimerViewVisible) // Pass the binding to TimerView
                                                    .frame(width: 300, height: 350)
                                                    .transition(.move(edge: .bottom))
                                            }
                },
                alignment: .bottom // Aligns TimerView to the bottom
            )
            
            
            // Recipe Title and Description
            VStack(alignment: .leading) {
                Text("Tteokbokki")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                
                
                ScrollView {
                    Text(stepDescription)
                        .font(.body)
                        .lineSpacing(5)
                }
                
                
            }
            .padding(.horizontal)
            
            Text("\(stepIndex)/\(totalSteps)")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
            
            // Bottom Navigation Bar
            HStack {
                Button(action: {
                    // Previous step action
                }) {
                    Image(systemName: "chevron.backward.2")
                        .foregroundColor(.black)
                        .bold()
                        .padding()
                        .background(Circle().fill(Color.white))
                }
                Spacer()
                Button(action: {
                    // Home action
                }) {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle()
                            .fill(Color.yellow)
                            .shadow(radius: 4))
                }
                Spacer()
                Button(action: {
                    // Next step action
                }) {
                    Image(systemName: "chevron.forward.2")
                        .foregroundColor(.black)
                        .bold()
                        .padding()
                        .background(Circle().fill(Color.white))
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
            .cornerRadius(20)
            .padding(.horizontal)
            .foregroundColor(.clear)
        }
        
    }
}

struct CookingModeView_Previews: PreviewProvider {
    static var previews: some View {
        CookingModeView()
    }
}
