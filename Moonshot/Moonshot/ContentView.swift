//
//  ContentView.swift
//  Moonshot
//
//  Created by Dany Blais Benoit on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            Text(String(astronauts.count))
        }
    }
}

#Preview {
    ContentView()
}
