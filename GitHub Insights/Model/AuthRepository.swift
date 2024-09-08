//
//  AuthRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

class AuthRepository {
    
    /// Shared Instance
    static let shared = AuthRepository()
    
    private init() {}
    
    func authenticate() async throws {
        let result: User = try await makeRequest(from: Constants.gitHubBaseURL+"users/smbrmoyo")
        print(result)
    }
}
