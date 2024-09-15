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
}

class ProfileRepository: ProfileRepositoryProtocol {
    
    /// Shared Instance
    static let shared = ProfileRepository()
    
    private init() {}
    
    func getUser() async throws -> User {
        guard let username = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") else {
            throw NetworkError.custom(message: "No user found. Please authenticate.")
        }
        
        return try await makeRequest(from: Constants.gitHubBaseURL+"users/\(username)")
    }
}
