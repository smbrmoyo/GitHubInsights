//
//  HomeRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

protocol HomeRepositoryProtocol {
    /**
     Retrieves the trending repositories of the week
     - parameter page `Int` page to fetch
     - returns The fetched `[GitHubRepo]`.
     */
    func fetchTrendingRepositories(page: Int) async throws -> FetchGitHubRepoResponse
}

class HomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = HomeRepository()
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> FetchGitHubRepoResponse {
        guard let secret = SecretsManager.getToken() else {
            throw NetworkError.unauthorized
        }
        
        
        return try await makeRequest(from: Constants.gitHubBaseURL+"search/repositories", parameters: ["q": "created", "per_page": "5"], headers: ["Authorization":"Bearer \(secret)"])
    }
}
