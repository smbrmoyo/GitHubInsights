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
    
    @Published var repositoryEvents: [RepositoryEvent] = []
    @Published var uiState = UIState.idle
    private var owner = ""
    private var name = ""
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: HomeRepositoryProtocol,
         gitHubRepo: GitHubRepo) {
        self.repository = repository
        self.owner = gitHubRepo.owner.login
        self.name = gitHubRepo.name
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchRepositoryEvents() async {
        do {
            uiState = .loading
            let result = try await repository.fetchRepositoryEvents(owner: owner, name: name, page: page)
            let filteredResult = result.filter { !repositoryEvents.contains($0) }
            repositoryEvents.append(contentsOf: filteredResult)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            ToastManager.shared.createToast(Toast(style: .error, message: "No Events found."))
        }
    }
}
