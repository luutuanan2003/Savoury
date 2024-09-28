//
//  CulinaryPreferencesView.swift
//  Savoury
//
//  Created by An Luu on 23/9/24.
//

import SwiftUI

/// This SwiftUI view is designed to guide users through setting up their dietary preferences and allergen alerts.
/// It features an introductory screen that leads to the SetupPreferencesView for detailed preference configuration.
struct CulinaryPreferencesView: View {
    
    @Binding var showCulinaryPreferencesView: Bool

    @State var show = false

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Help Savoury understand your culinary preferences")
                        .font(.title)
                        .fontWeight(.heavy)
                        .frame(width: 300)
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                }
                HStack{
                    Text("Complete these steps to set up your dietary and allergies")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .frame(width: 200)
                        .padding(.horizontal,25)
                    Spacer()
                }
                Spacer()
                Image("guyCooking")
                    .padding()
                Spacer()
                NavigationLink(destination: SetupPreferencesView(show: $show)){
                    Text("Next")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 200, height: 20)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(10.0)
                }
                Spacer()
            }
        }
        if show{
            SetupPreferencesView(show: $show)
            .transition(.move(edge: .leading))
            .zIndex(1)
        }
    }
}

#Preview {
    CulinaryPreferencesView(showCulinaryPreferencesView: .constant(true))
}
