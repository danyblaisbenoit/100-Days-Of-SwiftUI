//
//  Habit.swift
//  HabitTracker
//
//  Created by Dany Blais Benoit on 2025-01-11.
//

import Foundation


@Observable class Habit: Codable, Identifiable {
    var id: UUID
    let name: String
    let description: String
    var nbCompleted: Int
    
    init(name: String, description: String) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.nbCompleted = 0
    }
}
