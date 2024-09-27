//
//  AuthRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

protocol AuthRepositoryProtocol {
    /**
     Checks if the given username is a GitHub User and saves the username in the `UserDefaults`,
     - Parameters:
        - username: `String` The given username to check,
     - Returns: The retrieved `User` if successful.
     - Throws: Any `NetworkError` encountered during the request.
     */
    func authenticate(username: String) async throws -> User
    
    /**
     Signs out the saved user by removing the username from the `UserDefaults`,
     */
    func signOut()
}

final class AuthRepository: AuthRepositoryProtocol {
    
    /// Shared Instance
    static let shared = AuthRepository()
    
    private init() {}
    
    func authenticate(username: String) async throws -> User {
        do {
            let result: User = try await makeRequest(from: Endpoint.user(username: username).urlString)
            UserDefaults.standard.set(username, forKey: "GITHUB_USERNAME")
            return result
        } catch {
            print(error)
            throw error
        }
    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }
}
