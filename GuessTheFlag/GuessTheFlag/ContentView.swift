//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jan Kotur on 18/10/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please read this.")
        }
    }
}

#Preview {
    ContentView()
}
