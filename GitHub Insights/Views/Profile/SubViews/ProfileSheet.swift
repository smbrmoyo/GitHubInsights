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
            Capsule()
                        .foregroundColor(Color(.systemGray))
                        .frame(width: 50, height: 6)
                        .padding(.top, 10)
            
            Spacer()
            
            Button("Sign Out") {
                authViewModel.signOut()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ProfileSheet()
}
