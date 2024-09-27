//
//  SplashScreen.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image("Logo Launch")
                .resizable()
                .frame(width: 100, height: 100)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .task {
            await authViewModel.checkAuth()
        }
    }
}

#Preview {
    SplashScreen()
}
