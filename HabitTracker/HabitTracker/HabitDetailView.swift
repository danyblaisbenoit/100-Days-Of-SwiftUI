//
//  SwiftUIView.swift
//  HabitTracker
//
//  Created by Dany Blais Benoit on 2025-01-11.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: Habit
    @State private var timeCompleted: Int
    
    init(_ habit: Habit) {
        self.habit = habit
        _timeCompleted = State(initialValue: habit.nbCompleted)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form {
                    Section("Name") {
                        Text(habit.name)
                    }
                    Section("Description") {
                        Text(habit.description)
                    }
                    Section("Completed") {
                        HStack {
                            Text("\(habit.nbCompleted) times")
                            Spacer()
                            Stepper("", value: $timeCompleted, in: 0...Int.max)
                        }
                    }
                }
            }
            .navigationTitle("Edit habit")
            .onChange(of: timeCompleted) { oldValue, newValue in
                habit.nbCompleted = newValue
            }
        }
    }
}


#Preview {
    HabitDetailView(Habit(name: "Test name", description: "Test description"))
}
