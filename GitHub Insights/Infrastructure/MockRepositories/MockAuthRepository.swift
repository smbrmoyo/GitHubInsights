//
//  MockAuthRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 27.09.24.
//

import Foundation

final class MockAuthRepository: AuthRepositoryProtocol {
    
    /// Shared Instance
    static let shared = MockAuthRepository()
    
    var shouldFail = false
    
    private init() {}
    
    func authenticate(username: String) async throws -> User {
        guard !shouldFail else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch error"]) as Error
        }
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        return User.MOCK_USER
    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }
    
}
