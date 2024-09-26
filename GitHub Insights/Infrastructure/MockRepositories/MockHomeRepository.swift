//
//  MockHomeRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

class MockHomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = MockHomeRepository()
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> [GitHubRepo] {
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
    
    func fetchRepositoryEvents(owner: String, name: String, page: Int) async throws -> [RepositoryEvent] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let url = Bundle.main.url(forResource: "Events", withExtension: "json") else {
            throw NetworkError.custom(message: "JSON file not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let allRepos = try decoder.decode([RepositoryEvent].self, from: data)
            
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
