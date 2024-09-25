//
//  ProfileRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

protocol ProfileRepositoryProtocol {
    /**
     Retrieves the current `User` from GitHub based on the stored username in UserDefaults.
     - returns The fetched `User`.
     */
    func getUser() async throws -> User
    
    /**
     Retrieves the repositories of a user
     - parameter page `Int` page to fetch
     */
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo]
}

class ProfileRepository: ProfileRepositoryProtocol {
    
    /// Shared Instance
    static let shared = ProfileRepository()
    
    private init() {}
    
    func getUser() async throws -> User {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        return try await makeRequest(from: Endpoint.user(username: username).urlString)
    }
    
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo] {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let secret = SecretsManager.getToken() else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        return try await makeRequest(from: Endpoint.userRepositories(username: username).urlString,
                                     parameters: ["type": "all",
                                                  "sort": "updated",
                                                  "direction": "desc",
                                                  "per_page": "10",
                                                  "page": String(page)],
                                     headers: ["Authorization":"Bearer \(secret)"])
    }
}
