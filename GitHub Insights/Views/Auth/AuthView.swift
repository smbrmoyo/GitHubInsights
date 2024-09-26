//
//  AuthView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                Text("Authenticate")
                    .foregroundStyle(.white)
                    .font(.title)
                
                Spacer()
                
                BaseTextField(placeholder: "Type your username",
                              length: 25,
                              keyboardType: .default,
                              padding: 12,
                              isSecure: false,
                              textFieldName: "Username",
                              invalidTextHint: "",
                              regexes: [Regex.username],
                              text: $authViewModel.username,
                              isValidText: .constant(true))
                
                Button("Verify") {
                    authViewModel.authenticate()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel(repository: AuthRepository.shared))
        .environmentObject(ToastManager.shared)
}
