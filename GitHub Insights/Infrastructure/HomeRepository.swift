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
    func fetchTrendingRepositories(page: Int) async throws -> [GitHubRepo]
    
    /**
     Retrieves the latest events for a repository
     - parameter owner `String` owner of the repository
     - parameter name `String` name of the repository
     - parameter page `Int` page to fetch
     */
    func fetchRepositoryEvents(owner: String, name: String, page: Int) async throws -> [RepositoryEvent]
    
}

final class HomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = HomeRepository()
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> [GitHubRepo] {
        guard let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
        
        do {
            let result: FetchGitHubRepoResponse = try await makeRequest(from: Endpoint.search.urlString,
                                                                        parameters: ["sort": "stars",
                                                                                     "order": "desc",
                                                                                     "q": "created:>\(Date.getDateForLastWeek())",
                                                                                     "per_page": "20",
                                                                                     "page": String(page)],
                                                                        headers: ["Authorization":"Bearer \(secret)",
                                                                                  "X-GitHub-Api-Version": "2022-11-28",
                                                                                  "Accept": "application/vnd.github+json"])
            
            return result.items
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchRepositoryEvents(owner: String, name: String, page: Int) async throws -> [RepositoryEvent] {
        guard let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
        
        do {
            return try await makeRequest(from: Endpoint.events(owner: owner, repo: name).urlString,
                                         parameters: ["per_page": "20",
                                                      "page": String(page)],
                                         headers: ["Authorization":"Bearer \(secret)",
                                                   "X-GitHub-Api-Version": "2022-11-28",
                                                   "Accept": "application/vnd.github+json"])
        } catch {
            print(error)
            throw error
        }
    }
    
}
