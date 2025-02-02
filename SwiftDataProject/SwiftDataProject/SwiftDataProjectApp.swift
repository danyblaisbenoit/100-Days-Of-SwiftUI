//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Dany Blais Benoit on 2025-02-02.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
