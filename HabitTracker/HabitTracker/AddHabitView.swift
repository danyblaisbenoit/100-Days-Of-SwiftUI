//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Dany Blais Benoit on 2025-01-11.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    let habitManager: HabitManager
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Enter name", text: $name)
                    Section("Description") {
                        TextEditor(text: $description)
                            .frame(height: 100)
                    }
                }
            }
            .navigationTitle("Add habit")
            .toolbar {
                if validateInputs() {
                    Button("Save") {
                        habitManager.add(habit: Habit(name: name, description: description))
                        dismiss()
                    }
                }
            }
        }
    }
    
    func validateInputs() -> Bool {
        !name.isEmpty && !description.isEmpty
    }
}

#Preview {
    let habitManager = HabitManager()
    AddHabitView(habitManager: habitManager)
}
