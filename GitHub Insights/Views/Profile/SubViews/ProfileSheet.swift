//
//  ProfileSheet.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import SwiftUI

struct ProfileSheet: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Button("Sign Out") {
                authViewModel.signOut()
            }
            .buttonStyle(.borderedProminent)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ProfileSheet()
}
