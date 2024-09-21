//
//  HomeViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let repository: HomeRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var repositories: [GitHubRepo] = []
    @Published var uiState = UIState.idle
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchRepositories() async {
        do {
            uiState = repositories.isEmpty ?  .loading : .idle
            let result = try await repository.fetchTrendingRepositories(page: page).items
            repositories.append(contentsOf: result)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            ToastManager.shared.createToast(Toast(style: .error, message: "No repositories found."))
        }
    }
    
}
