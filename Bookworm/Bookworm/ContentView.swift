//
//  ContentView.swift
//  Bookworm
//
//  Created by Dany Blais Benoit on 2025-01-18.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let choosenFirstName = firstNames.randomElement()!
                    let choosenLastName = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(choosenFirstName) \(choosenLastName)")
                    
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
