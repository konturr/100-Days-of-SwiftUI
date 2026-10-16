//
//  ContentView.swift
//  LengthConv
//
//  Created by Jan Kotur on 16/10/2026.
//

import SwiftUI

enum VolumeUnit: String, CaseIterable {
    case mililiters = "mililiters"
    case liters = "liters"
    case cups = "cups"
    case pints = "pints"
    case gallons = "gallons"
    var multToMililiters: Double {
        switch self {
        case .mililiters:
            return 1.0
        case .liters:
            return 1000.0
        case .cups:
            return 236.59
        case .pints:
            return 473.18
        case .gallons:
            return 3785.41
        }
    }
}

struct ContentView: View {
    @FocusState private var isActive: Bool
    @State private var inputValue: Double = 0
    @State private var inputUnit: VolumeUnit = .liters
    @State private var outputUnit: VolumeUnit = .mililiters
    func convert(to targetUnit: VolumeUnit) -> Double {
        let mililiters = inputValue * inputUnit.multToMililiters
        let result = mililiters/targetUnit.multToMililiters
        return result
        
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("What to convert?") {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isActive)
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(VolumeUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Results") {
                    Text(String(format: "%.4f",convert(to: outputUnit)))
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(VolumeUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .toolbar {
            if isActive {
                Button("Done") {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
