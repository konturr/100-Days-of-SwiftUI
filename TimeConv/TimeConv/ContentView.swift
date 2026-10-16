//
//  ContentView.swift
//  TimeConv
//
//  Created by Jan Kotur on 16/10/2026.
//

import SwiftUI

enum TimeUnit: String, CaseIterable {
    case seconds = "seconds"
    case minutes = "minutes"
    case hours = "hours"
    case days = "days"
    
    var multiplierToSeconds: Double {
        switch self {
        case .seconds: return 1.0
        case .minutes: return 60.0
        case .hours: return 3600.0
        case .days: return 86400.0
        }
    }
}

struct ContentView: View {
    @FocusState private var valueIsFocused: Bool
    @State private var inputSelected: TimeUnit = .seconds
    @State private var outputSelected: TimeUnit = .minutes
    @State private var inputValue: String = ""
    
    func convert(to targetUnit: TimeUnit) -> String {
        guard let value = Double(inputValue) else {return "0"}
        let seconds = value * inputSelected.multiplierToSeconds
        let result = seconds / outputSelected.multiplierToSeconds
        return String(format: "%.2f", result)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("What do you want to convert?") {
                        TextField("Enter value", text: $inputValue)
                            .keyboardType(.decimalPad)
                            .focused($valueIsFocused)
                        
                        Picker("Input format", selection: $inputSelected) {
                            ForEach(TimeUnit.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section("Your result") {
                        Picker("Output format", selection: $outputSelected) {
                            ForEach(TimeUnit.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Text(convert(to: outputSelected))
                    }
                }
                .navigationTitle("TimeConv")
                .toolbar {
                    if valueIsFocused {
                        Button("Done") {
                            valueIsFocused = false
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
