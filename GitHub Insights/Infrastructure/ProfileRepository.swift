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
     - Returns: The fetched `User`.
     */
    func getUser() async throws -> User
    
    /**
     Retrieves the repositories of a user.
     - Parameters:
        - page: `Int` page to fetch.
     - Returns: The retrieved Array of `GitHubRepo` for the user.
     - Throws: Any `NetworkError` encountered during the request.
     */
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo]
    
    /**
     Retrieves the repositories starred by a user.
     - Parameters:
        - page: `Int` page to fetch.
     - Returns: The retrieved starred Array of `GitHubRepo`.
     - Throws: Any `NetworkError` encountered during the request.
     */
    func fetchStarredRepositories(page: Int) async throws -> [GitHubRepo]
    
    /**
     Retrieves the organization memberships of a user.
     - Parameters:
        - page: `Int` page to fetch.
     - Returns: The retrieved Array of  `Organization` for the user.
     - Throws: Any `NetworkError` encountered during the request.
     */
    func fetchOrganizations(page: Int) async throws -> [Organization]
}

final class ProfileRepository: ProfileRepositoryProtocol {
    
    /// Shared Instance
    static let shared = ProfileRepository()
    
    private init() {}
    
    func getUser() async throws -> User {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        do {
            return try await makeRequest(from: Endpoint.user(username: username).urlString,
                                         headers: ["Authorization":"Bearer \(secret)",
                                                   "X-GitHub-Api-Version": "2022-11-28",
                                                   "Accept": "application/vnd.github+json"])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo] {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        do {
            return try await makeRequest(from: Endpoint.userRepositories(username: username).urlString,
                                         parameters: ["type": "all",
                                                      "sort": "pushed",
                                                      "direction": "desc",
                                                      "per_page": "10",
                                                      "page": String(page)],
                                         headers: ["Authorization":"Bearer \(secret)",
                                                   "X-GitHub-Api-Version": "2022-11-28",
                                                   "Accept": "application/vnd.github+json"])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchStarredRepositories(page: Int) async throws -> [GitHubRepo] {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        do {
            return try await makeRequest(from: Endpoint.user(username: username).urlString + "/starred",
                                         parameters: ["sort": "created",
                                                      "direction": "desc",
                                                      "per_page": "10",
                                                      "page": String(page)],
                                         headers: ["Authorization":"Bearer \(secret)",
                                                   "X-GitHub-Api-Version": "2022-11-28",
                                                   "Accept": "application/vnd.github+json"])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchOrganizations(page: Int) async throws -> [Organization] {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let secret = SecretsManager.shared.getToken() else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        do {
            return try await makeRequest(from: Endpoint.user(username: username).urlString + "/orgs",
                                         parameters: ["per_page": "10",
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
