//
//  AuthRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

final class AuthRepository {
    
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
