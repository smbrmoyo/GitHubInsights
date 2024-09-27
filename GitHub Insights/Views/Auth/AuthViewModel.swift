//
//  AuthViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    let repository: AuthRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var username = ""
    @Published var launchState = LaunchState.launch
    
    // MARK: - Lifecycle
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func checkAuth() async {
        guard let storedUsername = UserDefaults.standard.string(forKey: "GITHUB_USERNAME") else {
            launchState = .auth
            return
        }
        
        do {
            let _ = try await repository.authenticate(username: storedUsername)
            
            launchState = .session
        } catch {
            launchState = .auth
            ToastManager.shared.createToast(Toast(style: .error, message: "An unknown error occurred."))
        }
    }
    
    @MainActor
    func authenticate() async {
        do {
            let result = try await repository.authenticate(username: username)
            if result != User.EMPTY_USER {
                launchState = .session
            }
        } catch {
            launchState = .auth
            ToastManager.shared.createToast(Toast(style: .error, message: "No matching username found."))
        }
    }
    
    func signOut() {
        repository.signOut()
        launchState = .auth
    }
}
