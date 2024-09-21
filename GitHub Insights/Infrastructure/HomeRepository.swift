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
    
    /**
     Retrieves the latest activity for a repository
     - parameter owner `String` owner of the repository
     - parameter name `String` name of the repository
     */
    func fetchRepositoryActivity(owner: String, name: String) async throws -> [RepositoryActivity]
}

class HomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = HomeRepository()
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> FetchGitHubRepoResponse {
        guard let secret = SecretsManager.getToken() else {
            throw NetworkError.unauthorized
        }
        
        do {
            return try await makeRequest(from: Endpoint.search.urlString,
                                         parameters: ["sort": "stars",
                                                      "order": "desc",
                                                      "q": "created:>\(Date.getDateForLastWeek())",
                                                      "per_page": "20",
                                                      "page": String(page)],
                                         headers: ["Authorization":"Bearer \(secret)"])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchRepositoryActivity(owner: String, name: String) async throws -> [RepositoryActivity] {
        do {
            return try await makeRequest(from: Endpoint.activity(owner: owner, repo: name).urlString)
        } catch {
            print(error)
            throw error
        }
    }
    
}
