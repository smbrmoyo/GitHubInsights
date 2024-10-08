//
//  HomeViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let repository: HomeRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var repositories: [GitHubRepo] = []
    @Published var uiState = UIState.idle
    @Published var canRefresh = true
    var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchRepositories() async {
        do {
            uiState = repositories.isEmpty ?  .loading : .idle
            let result = try await repository.fetchTrendingRepositories(page: page)
            let filteredResult = result.filter { repo in
                !repositories.contains(where: { repo.id == $0.id })
            }
            
            guard !filteredResult.isEmpty else {
                uiState = .idle
                canRefresh = false
                return
            }
            
            repositories.append(contentsOf: filteredResult)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            canRefresh = false
            ToastManager.shared.createToast(Toast(style: .error, message: "No repositories found."))
        }
    }
    
}
