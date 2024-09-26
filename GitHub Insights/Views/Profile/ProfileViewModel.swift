//
//  ProfileViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let repository: ProfileRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var user = User.EMPTY_USER
    @Published var uiState = UIState.idle
    @Published var showLogOutSheet = false
    @Published var showShareSheet = false
    var shareURL: URL? {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String else { return nil }
        
        return URL(string: Endpoint.profile(username: username).urlString)
    }
    
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
