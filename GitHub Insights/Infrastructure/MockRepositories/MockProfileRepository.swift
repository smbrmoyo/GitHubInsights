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
    
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo] {
        try await Task.sleep(nanoseconds: 500_000_000)

        guard let url = Bundle.main.url(forResource: "Repositories", withExtension: "json") else {
            throw NetworkError.custom(message: "JSON file not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let allRepos = try decoder.decode([GitHubRepo].self, from: data)
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allRepos.count)
            
            guard startIndex < allRepos.count else {
                return []
            }
            
            return Array(allRepos[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchStarredRepositories(page: Int) async throws -> [GitHubRepo] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let url = Bundle.main.url(forResource: "Repositories", withExtension: "json") else {
            throw NetworkError.custom(message: "JSON file not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let allRepos = try decoder.decode([GitHubRepo].self, from: data)
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allRepos.count)
            
            guard startIndex < allRepos.count else {
                return []
            }
            
            return Array(allRepos[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchOrganizations(page: Int) async throws -> [Organization] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let url = Bundle.main.url(forResource: "Organizations", withExtension: "json") else {
            throw NetworkError.custom(message: "JSON file not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let allRepos = try decoder.decode([Organization].self, from: data)
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allRepos.count)
            
            guard startIndex < allRepos.count else {
                return []
            }
            
            return Array(allRepos[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
}
