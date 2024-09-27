//
//  ProfileViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let repository: ProfileRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var user = User.EMPTY_USER
    @Published var uiState = UIState.idle
    @Published var showLogOutSheet = false
    
    // MARK: - Lifecycle
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func getUser() async {
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
