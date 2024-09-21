//
//  RepositoryDetailViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import Foundation

class RepositoryDetailViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let repository: HomeRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var repositoryActivities: [RepositoryActivity] = []
    @Published var uiState = UIState.idle
    private var owner = ""
    private var name = ""
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: HomeRepositoryProtocol, gitHubRepo: GitHubRepo) {
        self.repository = repository
        self.owner = gitHubRepo.owner.login
        self.name = gitHubRepo.name
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchRepositoryActivity() async {
        do {
            uiState = .loading
            let result = try await repository.fetchRepositoryActivity(owner: owner, name: name)
            repositoryActivities.append(contentsOf: result)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            ToastManager.shared.createToast(Toast(style: .error, message: "No activity found."))
        }
    }
}
