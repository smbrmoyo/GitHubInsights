//
//  ContentView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 07.09.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hey")
        }
        .onAppear {
            Task {
                do{
                    try await AuthRepository.shared.authenticate()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
