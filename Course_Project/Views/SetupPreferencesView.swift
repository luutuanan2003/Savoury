//
//  SetupPreferencesView.swift
//  Savoury
//
//  Created by An Luu on 23/9/24.
//

import SwiftUI

/// This SwiftUI view facilitates the configuration of user dietary preferences and allergy selections.
/// It features an interactive list where users can select their allergies and diet preferences using multiple-choice options. The selections are managed through dynamic updates to the binding sets of selectedAllergies and selectedDiets.
struct SetupPreferencesView: View {
    @Binding var show: Bool
    @State private var selectedAllergies: Set<Allergy> = []
    @State private var selectedDiets: Set<Diet> = []

    var body: some View {
        VStack{
            NavigationStack{
                List {
                    Section(header: Text("Allergies")) {
                        ForEach(Allergy.allCases, id: \.self) { allergy in
                            MultipleChoiceRow(title: allergy.description, isSelected: selectedAllergies.contains(allergy)) {
                                if selectedAllergies.contains(allergy) {
                                    selectedAllergies.remove(allergy)
                                } else {
                                    selectedAllergies.insert(allergy)
                                }
                            }
                        }
                    }

                    Section(header: Text("Diets")) {
                        ForEach(Diet.allCases, id: \.self) { diet in
                            MultipleChoiceRow(title: diet.description, isSelected: selectedDiets.contains(diet)) {
                                if selectedDiets.contains(diet) {
                                    selectedDiets.remove(diet)
                                } else {
                                    selectedDiets.insert(diet)
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationBarTitle("Culinary Preferences")
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

struct SetupPreferences_Previews: PreviewProvider {
    static var previews: some View {
        SetupPreferencesView(show: .constant(true))
    }
}
