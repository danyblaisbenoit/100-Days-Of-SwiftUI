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
    
    let grid = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let column = [
        GridItem(.fixed(300))
    ]
    
    @State private var gridDisplay = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridDisplay ? grid : column) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackGround)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackGround)
                                )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Change display") {
                    gridDisplay.toggle()
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
