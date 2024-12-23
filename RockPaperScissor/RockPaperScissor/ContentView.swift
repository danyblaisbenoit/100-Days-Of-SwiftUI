//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Dany Blais Benoit on 2024-12-23.
//

// Rock, Paper, Scissors.
// - Each turn of the game the app will randomly pick either rock, paper or scissors.
// - Each turn the app will alternate between prompting the player to win or lose.
// - The player must then tap the correct move to win or lose the game.
// - If they are correct they score a point; otherwise they lose a point.
// - The games ends after 10 questions, at which point their score is shown.
// So, if the app chose "Rock" and "Win" the player would need to choose "Paper", but if the app chose "Rock" and "Lose" the player would need to choose "Scissors".


import SwiftUI

// View that display an icon
struct IconDisplay: View {
    let iconZize: CGFloat = 110
    let largeIconIze: CGFloat = 180
    
    var icon: String
    var isLarge: Bool
    
    var body: some View {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: isLarge ? largeIconIze: iconZize, height: isLarge ? largeIconIze: iconZize)
                .background {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.ultraThinMaterial)
                }
                .padding()
        }
}

struct ContentView: View {
    @State private var icons = ["rock", "paper", "scissors"]
    @State private var shouldWin: Bool = true
    @State private var opponentMove: String = "rock"
    @State private var score: Int = 0
    @State private var round: Int = 1
    @State private var gameEnds: Bool = false
    
    let maxRound = 10
    
    private func nextRound(myMove: String) {
        if gameLogic(myMove: myMove, opponentMove: opponentMove) == shouldWin {
            score += 1
        } else {
            score -= 1
        }
        
        round += 1
        
        if round > maxRound {
            gameEnds = true
            return
        }
        
        icons.shuffle()
        shouldWin = Bool.random()
        opponentMove = icons.randomElement() ?? "rock"
    }
    
    private func resetGame() {
        round = 1
        score = 0
        icons.shuffle()
        shouldWin = Bool.random()
        opponentMove = icons.randomElement() ?? "rock"
    }
    
    private func gameLogic(myMove: String, opponentMove: String) -> Bool {
        if myMove == "rock" {
            if opponentMove == "scissors" {
                return true
            } else {
                return false
            }
        } else if myMove == "paper" {
            if opponentMove == "rock" {
                return true
            } else {
                return false
            }
        } else if myMove == "scissors" {
            if opponentMove == "paper" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            // Background color
            LinearGradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                // Title
                Text("Rock Paper Scissors!")
                    .foregroundStyle(.primary)
                    .font(.largeTitle)
                    .italic()
                
                Spacer()
                
                Text("Your opponent move")
                    .foregroundStyle(.primary)
                    .font(.callout)
                
                IconDisplay(icon: opponentMove, isLarge: true)
                
                Spacer()
                
                Text("\(shouldWin ? "Win": "Lose"), your move!")
                
                HStack(spacing: 0) {
                    ForEach(icons, id: \.self) { icon in
                        Button() {
                            nextRound(myMove: icon)
                        } label: {
                            IconDisplay(icon: icon, isLarge: false)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer()
            }
        }
        .alert("Game ended! You scored \(score)/\(maxRound)", isPresented: $gameEnds) {
            Button("Play again") {
                resetGame()
            }
        }
    }
}

#Preview {
    ContentView()
}
