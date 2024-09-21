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
    
    func fetchRepositoryActivity(owner: String, name: String) async throws -> [RepositoryActivity] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return RepositoryActivity.MOCK_REPO_ACTIVITY
    }
}
