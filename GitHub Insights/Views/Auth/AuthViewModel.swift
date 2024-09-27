//
//  AuthViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    let repository: AuthRepository
    
    // MARK: - Properties
    
    @Published var username = ""
    @Published var launchState = LaunchState.launch
    
    // MARK: - Lifecycle
    
    init(repository: AuthRepository) {
        self.repository = repository
        
        checkAuth()
    }
    
    // MARK: - Functions
    
    private func checkAuth() {
        guard let storedUsername = UserDefaults.standard.string(forKey: "GITHUB_USERNAME") else {
            launchState = .auth
            return
        }
        
        Task {
            do {
                let _ = try await repository.authenticate(username: storedUsername)
                
                launchState = .session
            } catch {
                launchState = .auth
                ToastManager.shared.createToast(Toast(style: .error, message: "An unknown error occurred."))
            }
        }
    }
    
    func authenticate() {
        Task {
            do {
                let result = try await repository.authenticate(username: username)
                if result != User.EMPTY_USER {
                        launchState = .session
                }
            } catch {
                ToastManager.shared.createToast(Toast(style: .error, message: "No matching username found."))
            }
        }
    }
    
    func signOut() {
        repository.signOut()
            launchState = .auth
    }
}
