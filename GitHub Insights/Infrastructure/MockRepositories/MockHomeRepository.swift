//
//  MockHomeRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

class MockHomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = MockHomeRepository()
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> FetchGitHubRepoResponse {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return FetchGitHubRepoResponse(items: [GitHubRepo.MOCK_GITHUB_REPO])
    }
    
    func fetchRepositoryEvents(owner: String, name: String, page: Int) async throws -> [RepositoryEvent] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return RepositoryEvent.MOCK_REPOSITORY_EVENT
    }
}
