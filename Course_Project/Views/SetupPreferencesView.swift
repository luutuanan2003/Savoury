import SwiftUI
import SwiftData

/// This SwiftUI view facilitates the configuration of user dietary preferences and allergy selections.
/// It features an interactive list where users can select their allergies and diet preferences using multiple-choice options.
struct SetupPreferencesView: View {
    
    /// Binding to pass the username from CulinaryPreferencesView.
    @Binding var username: String
    
    /// Binding to control the visibility of the setup view.
    @Binding var showSetUp: Bool
    
    /// State to track user-selected allergies.
    @State var selectedAllergies: [String] = []
    
    /// State to track user-selected dietary preferences.
    @State var selectedDiets: [String] = []
    
    /// State to control the alert
    @State private var showAlert = false
    
    /// State to control navigation to HomeView
    @State private var showHomeView = false
    
    /// Access UserDefaults for saving and retrieving local data.
    let defaults = UserDefaults.standard

    var body: some View {
        ZStack {
            if !showHomeView {  // Only show SetupPreferencesView when HomeView is not active
            VStack {
                NavigationStack {
                    List {
                        Section(header: Text("Allergies")) {
                            ForEach(Allergy.allCases, id: \.self) { allergy in
                                MultipleChoiceRow(
                                    title: allergy.description,
                                    isSelected: selectedAllergies.contains(allergy.description)
                                ) {
                                    if let index = selectedAllergies.firstIndex(of: allergy.description) {
                                        selectedAllergies.remove(at: index)
                                    } else {
                                        selectedAllergies.append(allergy.description)
                                    }
                                }
                            }
                        } // Section
                        
                        Section(header: Text("Diets")) {
                            ForEach(Diet.allCases, id: \.self) { diet in
                                MultipleChoiceRow(
                                    title: diet.description,
                                    isSelected: selectedDiets.contains(diet.description)
                                ) {
                                    if let index = selectedDiets.firstIndex(of: diet.description) {
                                        selectedDiets.remove(at: index)
                                    } else {
                                        selectedDiets.append(diet.description)
                                    }
                                }
                            }
                        } // section
                    } // List
                    .navigationBarTitle("Culinary Preferences")
                } // Navigation Stack
                Text("Confirm")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 200, height: 20)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(10.0)
                    .onTapGesture {
                        
                        // Save selected preferences
                        defaults.set(selectedAllergies, forKey: "selectedAllergies")
                        defaults.set(selectedDiets, forKey: "selectedDiets")
                        // Trigger the alert when user taps confirm
                            showAlert = true
                        } // Tap Gesture
                        .alert("Reminder", isPresented: $showAlert, actions: {
                            Button {
                                // Navigate to HomeView
                                showHomeView = true
                            } label: {
                                Text("Yes")
                            }
                            
                            Button(role: .cancel, action: {}) {
                                Text("No")
                            }

                        }, message: {
                            Text("Preferences are set. Do you wish to exit?")
                        })
                    } // VStack
            .onAppear {
                // Load saved preferences
                if let savedAllergies = defaults.array(forKey: "selectedAllergies") as? [String] {
                    selectedAllergies = savedAllergies
                }
                if let savedDiets = defaults.array(forKey: "selectedDiets") as? [String] {
                    selectedDiets = savedDiets
                }
            }
                }
            if showHomeView{
                HomeView(username: username)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .navigationBarBackButtonHidden(true)  // Hide the back button
            }
        } // ZStack
    }

    
    /// Define a subview for multiple-choice rows.
    struct MultipleChoiceRow: View {
        var title: String
        var isSelected: Bool
        var toggleSelection: () -> Void
        
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                toggleSelection()
            }
        }
    }
}

#Preview {
    SetupPreferencesView(username: .constant("dummy"),showSetUp: .constant(true))
}
