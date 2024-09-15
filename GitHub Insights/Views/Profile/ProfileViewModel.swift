//
//  ProfileViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    // MARK: - Dependencies
    let repository: ProfileRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var user = User.DEFAUL_TUSER
    @Published var uiState = UIState.idle
    
    // MARK: - Lifecycle
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    func getUser() {
        Task {
            do {
                uiState = .loading
                user = try await repository.getUser()
                uiState = .idle
            } catch {
                uiState = .idle
                ToastManager.shared.createToast(Toast(style: .error, message: "No user found."))
            }
        }
    }
}
