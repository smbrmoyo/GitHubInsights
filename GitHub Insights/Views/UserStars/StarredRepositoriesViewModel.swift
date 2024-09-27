//
//  StarredRepositoriesViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 25.09.24.
//

import Foundation

final class StarredRepositoriesViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let repository: ProfileRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var repositories: [GitHubRepo] = []
    @Published var uiState = UIState.idle
    @Published var isRefreshing = false
    @Published var canRefresh = true
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchStarredRepositories() async {
        do {
            uiState = repositories.isEmpty ?  .loading : .idle
            let result = try await repository.fetchStarredRepositories(page: page)
            
            guard !result.isEmpty else {
                uiState = .idle
                canRefresh = false
                return
            }
            
            repositories.append(contentsOf: result)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            ToastManager.shared.createToast(Toast(style: .error, message: "No Starred Repositories found."))
        }
    }
}
