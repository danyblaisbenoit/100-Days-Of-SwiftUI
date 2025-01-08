//
//  ContentView.swift
//  Navigation
//
//  Created by Dany Blais Benoit on 2025-01-07.
//

import SwiftUI

struct Student: Hashable {
    let id = UUID()
    let name: String
    let age: Int
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

#Preview {
    ContentView()
}
