//
//  MockProfileRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

class MockProfileRepository: ProfileRepositoryProtocol {
    /// Shared Instance
    static let shared = MockProfileRepository()
    
    private init() {}
    
    func getUser() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return User.MOCK_USER
    }
}
