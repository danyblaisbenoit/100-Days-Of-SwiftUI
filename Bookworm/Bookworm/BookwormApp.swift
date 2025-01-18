//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Dany Blais Benoit on 2025-01-18.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
