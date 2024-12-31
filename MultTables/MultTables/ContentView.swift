//
//  ContentView.swift
//  MultTables
//
//  Created by Dany Blais Benoit on 2024-12-30.
//

// Goal is to build an “edutainment” app for kids to help them
// practice multiplication tables – “what is 7 x 8?” and so on.
// Edutainment apps are educational at their core, but ideally have
// enough playfulness about them to make kids want to play.

// The player needs to select which multiplication tables they
// want to practice. This could be pressing buttons, or it could be
// an “Up to…” stepper, going from 2 to 12.

// The player should be able to select how many questions they want to be asked:
// 5, 10, or 20.

// You should randomly generate as many questions as they asked for, within the
// difficulty range they asked for.

// Start with an App template, then add some state to determine whether the game is
// active or whether you’re asking for settings.

// Generate a range of questions based on the user’s settings.

//Show the player how many questions they got correct at the end of the game, then offer to let them play again.

import SwiftUI

let pickerSelections: [Int] = [5, 10, 20]

struct SettingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.orange)
    }
}

struct StartGameButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Start Game")
                .font(.title)
        }
        .frame(width: 200, height: 100)
        .background(.indigo)
        .foregroundStyle(.primary)
        .clipShape(Capsule())
    }
}

struct NumpadButton: View {
    let number: Int
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button() {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            isPressed = false
            action()
        } label: {
            Text("\(number)")
                .font(.title)
                .frame(width: 100, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.indigo)
                )
                .foregroundStyle(.white)
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
    }
}

struct ReturnButton: View {
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            isPressed = false
            action()
        } label: {
            Image(systemName: "delete.left")
                .font(.title)
                .frame(width: 100, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.red)
                )
                .foregroundStyle(.white)
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
    }
}

struct SubmitButton: View {
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            isPressed = false
            action()
        } label: {
            Text("Submit")
                .font(.title)
                .frame(width: 100, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.green)
                )
                .foregroundStyle(.white)
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
    }
}

struct SettingView: View {
    let difficultyBinding: Binding<Int>
    let numberOfQuestionsBinding: Binding<Int>
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Tables up to...")
                .modifier(SettingStyle())
            Stepper(value: difficultyBinding, in: 2...12) {
                Text("\(difficultyBinding.wrappedValue)")
            }
            Spacer()
            Text("Number of questions...")
                .modifier(SettingStyle())
            Picker("", selection: numberOfQuestionsBinding) {
                ForEach(pickerSelections, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.segmented)
            Spacer()
        }
        .padding()
        StartGameButton() {
            action()
        }
    }
}

struct ContentView: View {
    @State private var difficulty: Int = 8
    @State private var numberOfQuestions: Int = 10
    @State private var currentQuestion: Int = 0
    @State private var score: Int = 0
    @State private var gameStarted: Bool = false
    @State private var leftNumber: [Int] = []
    @State private var rightNumber: [Int] = []
    @State private var answerTable: [Int] = []
    @State private var answer: String = ""
    @State private var alertPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            if !gameStarted {
                SettingView(difficultyBinding: $difficulty, numberOfQuestionsBinding: $numberOfQuestions) {
                    startGame()
                }
            } else {
                VStack {
                    Spacer()
                    Text("\(leftNumber[currentQuestion]) x \(rightNumber[currentQuestion]) = \(answer)")
                        .foregroundStyle(.orange)
                        .font(.title)
                        .bold()
                        .scaleEffect(2.0)
                    Spacer()
                    VStack {
                        ForEach (1..<4) { row in
                            HStack {
                                ForEach (1..<4) { col in
                                    let number = 3 * (row - 1) + col
                                    NumpadButton(number: number) {
                                        numberTap(number)
                                    }
                                }
                            }
                        }
                        HStack {
                            ReturnButton {
                                returnTap()
                            }
                            NumpadButton(number: 0) {
                                numberTap(0)
                            }
                            SubmitButton {
                                submitTap()
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Reset") {
                            resetGame()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Text("Question \(currentQuestion + 1)/\(numberOfQuestions)")
                    }
                }
                .alert("Game Ends, you scored: \(score)", isPresented: $alertPresented) {
                    Button("Restart") {
                        resetGame()
                    }
                }
            }
        }
    }
    
    func startGame() {
        // Setting up arrays
        leftNumber = (0...numberOfQuestions).map{ _ in Int.random(in: 0...difficulty)}
        rightNumber = (0...numberOfQuestions).map{ _ in Int.random(in: 0...difficulty)}
        
        for i in 0..<numberOfQuestions {
            answerTable.append(leftNumber[i] * rightNumber[i])
        }
                        
        // Start game
        gameStarted = true
    }
    
    func resetGame() {
        // Clear arrays
        leftNumber.removeAll()
        rightNumber.removeAll()
        answerTable.removeAll()
        answer.removeAll()
        
        currentQuestion = 0
        score = 0
        
        // Reset game
        gameStarted = false
    }
    
    func numberTap(_ number: Int) {
        if answer.count < 3 {
            answer.append(String(number))
        }
    }
    
    func returnTap() {
        if answer.count > 0 {
            answer.removeLast()
        }
    }
    
    func submitTap() {
        if Int(answer) == answerTable[currentQuestion] {
            score += 1
        }
        
        answer.removeAll()
        
        if currentQuestion < numberOfQuestions - 1 {
            currentQuestion += 1
        } else {
            alertPresented = true
        }
    }
}

#Preview {
    ContentView()
}
