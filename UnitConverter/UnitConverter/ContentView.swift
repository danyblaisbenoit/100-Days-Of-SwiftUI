//
//  ContentView.swift
//  UnitConverter
//
//  Created by Dany Blais Benoit on 2024-12-20.
//

import SwiftUI

// Unit type to provide to the users
enum UnitType: String, CaseIterable, Identifiable {
    case Length
    case Temperature
    case Speed
    case Angle
    case Mass
    
    var id: String { self.rawValue }
}

// Extension of Swift UnitSpeed class to add the ft/sec speed unit
extension UnitSpeed {
    static let feetsPerSecond: UnitSpeed = UnitSpeed(symbol: "ft/sec", converter: UnitConverterLinear(coefficient: 0.3048)) // 1 m/s = 0.3848 ft/sec
}

// Available units for length
let lengthUnits: [Dimension] = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.inches, UnitLength.nauticalMiles]

// Available units for temperature
let temperatureUnits: [Dimension] = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]

// Available units for speed
let speedUnits: [Dimension] = [UnitSpeed.metersPerSecond, UnitSpeed.kilometersPerHour, UnitSpeed.feetsPerSecond, UnitSpeed.knots]

// Available unit for angle
let angleUnits: [Dimension] = [UnitAngle.degrees, UnitAngle.radians]

// Avaiable units for mass
let massUnits: [Dimension] = [UnitMass.kilograms, UnitMass.pounds]

// Dictionnary of the different units per type
var unitDictionnary: [UnitType: [Dimension]] = [
    .Length : lengthUnits,
    .Temperature : temperatureUnits,
    .Speed : speedUnits,
    .Angle: angleUnits,
    .Mass: massUnits
]

struct ContentView: View {
    // User input variables
    @State private var selectedUnitType: UnitType = .Length
    @State private var selectedInputUnit: Dimension = unitDictionnary[.Length]?.first ?? UnitLength.meters
    @State private var selectedOutputUnit: Dimension = unitDictionnary[.Length]?.last ?? UnitLength.kilometers
    @State private var inputValue: Double = 0.0
    @FocusState private var isFocused: Bool
    
    var outputUnits: [Dimension] {
        // Removes the input unit from the output units selection
        unitDictionnary[selectedUnitType]?.filter { $0 != selectedInputUnit } ?? []
    }
    
    var outputValue: Double {
        // Input value is converted from the input unit to the output unit using the Measurement class.
        let inputMeasure = Measurement(value: inputValue, unit: selectedInputUnit)
        let outputMeasure = inputMeasure.converted(to: selectedOutputUnit)
        return outputMeasure.value
    }
    
    private func updateDefaultUnit() {
        // On unit type change the input/output units must be updated
        if let unit = unitDictionnary[selectedUnitType]?.first {
            selectedInputUnit = unit
        }
        
        if let unit = unitDictionnary[selectedUnitType]?.last {
            selectedOutputUnit = unit
        }
    }
    
    private func updateSelectedOutputUnit() {
        // If the selected input unit is the current selected output unit, select a different output unit
        if selectedInputUnit == selectedOutputUnit {
            if let outputUnit = outputUnits.first {
                selectedOutputUnit = outputUnit
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Unit Type", selection: $selectedUnitType) {
                        ForEach (UnitType.allCases) { unitType in
                            Text(unitType.rawValue).tag(unitType)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedUnitType, updateDefaultUnit)
                }
                
                Section("From") {
                    HStack {
                        TextField("Enter value", value: $inputValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        Text(selectedInputUnit.symbol)
                    }
                    
                    Picker("", selection: $selectedInputUnit) {
                        if let units = unitDictionnary[selectedUnitType] {
                            ForEach (units, id: \.self) { unit in
                                Text(unit.symbol).tag(unit)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedInputUnit, updateSelectedOutputUnit)
                }
                
                Section("To") {
                    HStack {
                        Text(outputValue, format: .number)
                        Spacer()
                        Text(selectedOutputUnit.symbol)
                    }
                    
                    Picker("", selection: $selectedOutputUnit) {
                        if !outputUnits.isEmpty {
                            ForEach (outputUnits, id: \.self) { unit in
                                Text(unit.symbol).tag(unit)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
