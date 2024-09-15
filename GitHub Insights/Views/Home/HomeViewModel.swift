//
//  HomeViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Dependencies
    let repository: HomeRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var repositories: [GitHubRepo] = []
    @Published var uiState = UIState.idle
    private var page = 1
    
    // MARK: - Lifecycle
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    func fetchRepositories() {
        Task {
            do {
                uiState = .loading
                repositories = try await repository.fetchTrendingRepositories(page: page).items
                page += 1
                uiState = .idle
                print(repositories)
            } catch {
                uiState = .idle
                ToastManager.shared.createToast(Toast(style: .error, message: "No repositories found."))
            }
        }
    }
}
