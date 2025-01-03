//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dany Blais Benoit on 2024-12-21.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    let animationAmount: Double
    let isFade: Bool
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            .opacity(isFade ? 0.25 : 1.0)
            .animation(.easeInOut(duration: 0.5), value: isFade)
            .scaleEffect(isFade ? 0.5 : 1.0)
            .animation(.easeIn(duration: 0.5), value: isFade)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round : Int = 1
    @State private var animationAmount: Double = 0
    @State private var isFade: [Bool] = [false, false, false]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200.0, endRadius: 700.0)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            animationAmount += 360
                            for i in 0..<3 {
                                isFade[i] = true
                            }
                            isFade[number] = false
                            
                        } label: {
                            FlagImage(country: countries[number], animationAmount: animationAmount, isFade: isFade[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if round < 9 {
                Button("Continue") {
                    askQuestion()
                }
            } else {
                Button("Replay") {
                    askQuestion()
                }
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct, Score: \(score)"
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        round += 1
        
        if round > 8 {
            scoreTitle = "Game ends! Score: \(score)"
            score = 0
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        for i in 0..<3 {
            isFade[i] = false
        }
    }
}

#Preview {
    ContentView()
}
