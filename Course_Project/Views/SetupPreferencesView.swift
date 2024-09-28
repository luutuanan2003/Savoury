import SwiftUI
import SwiftData

/// This SwiftUI view facilitates the configuration of user dietary preferences and allergy selections.
/// It features an interactive list where users can select their allergies and diet preferences using multiple-choice options.
struct SetupPreferencesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var show: Bool
    @State var selectedAllergies: [String] = []
    @State var selectedDiets: [String] = []

    var body: some View {
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
                    }
                    
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
                    }
                }
                .navigationBarTitle("Culinary Preferences")
            }
            Text("Confirm")
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 200, height: 20)
                .padding()
                .foregroundColor(.black)
                .background(Color.yellow)
                .cornerRadius(10.0)
                .onTapGesture {
                    let newPreferences = userPreferences(allergies: selectedAllergies, diets: selectedDiets)
                    modelContext.insert(newPreferences)
                }
        }
    }
}
    

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

#Preview {
    SetupPreferencesView(show: .constant(true))
        .modelContainer(for: userPreferences.self)
}
