//
//  GitHub_InsightsApp.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 07.09.24.
//

import SwiftUI

@main
struct GitHub_InsightsApp: App {
    @StateObject var authViewModel = AuthViewModel(repository: AuthRepository.shared)
    @StateObject private var toastManager = ToastManager.shared
    
    var body: some Scene {
        WindowGroup {
            VStack {
                switch authViewModel.launchState {
                case .launch:
                    SplashScreen()
                    
                case .auth:
                    AuthView()
                    
                case .session:
                    MainTabView()
                }
            }
            .environmentObject(authViewModel)
            .environment(\.colorScheme, .dark)
            .toast(toast: $toastManager.toast)
        }
    }
}
