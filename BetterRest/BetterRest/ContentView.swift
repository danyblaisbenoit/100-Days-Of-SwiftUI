//
//  ContentView.swift
//  BetterRest
//
//  Created by Dany Blais Benoit on 2024-12-24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var bedTime = ""
        
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Better Rest") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .font(.headline)
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .font(.headline)
                
                Section("Daily coffee intake") {
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { amount in
                            Text("\(amount)")
                        }
                    }
                }
                .font(.headline)
                
                Section("You're ideal bed time") {
                    Text(calculateBedTime())
                }
                .font(.headline)
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            print("Could not calculate bed time")
            return ""
        }
    }
}

#Preview {
    ContentView()
}
