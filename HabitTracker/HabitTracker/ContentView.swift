//
//  ContentView.swift
//  HabitTracker
//
//  Created by Dany Blais Benoit on 2025-01-11.
//

import SwiftUI

struct ContentView: View {
    let habitManager = HabitManager()
    
    @State private var addHabitViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(habitManager.habits) { habit in
                        NavigationLink(destination: HabitDetailView(habit)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .foregroundStyle(.primary)
                                    Text(habit.description)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("Done \(habit.nbCompleted) times")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .onDelete(perform: habitManager.remove)
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        addHabitViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24).bold())
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
            .background(.clear)
            .navigationTitle("Habit tracker")
            .sheet(isPresented: $addHabitViewPresented) {
                AddHabitView(habitManager: habitManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
