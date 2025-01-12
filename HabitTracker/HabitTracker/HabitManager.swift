//
//  HabitManager.swift
//  HabitTracker
//
//  Created by Dany Blais Benoit on 2025-01-11.
//

import Foundation

@Observable class HabitManager {
    private let storageKey = "Habits"
    private(set) var habits = [Habit]()
    
    init() {
        loadHabits()
    }
    
    func add(habit: Habit) {
        habits.append(habit)
        saveHabits()
    }
    
    func remove(at indexSet: IndexSet) {
        habits.remove(atOffsets: indexSet)
        saveHabits()
    }
    
    func loadHabits() {
        if let savedHabits = UserDefaults.standard.data(forKey: storageKey) {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
            }
        }
    }
    
    func saveHabits() {
        if let encodedHabits = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encodedHabits, forKey: storageKey)
        }
    }
}
