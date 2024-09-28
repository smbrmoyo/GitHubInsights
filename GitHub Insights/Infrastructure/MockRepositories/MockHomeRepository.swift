//
//  MockHomeRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import Foundation

final class MockHomeRepository: HomeRepositoryProtocol {
    
    /// Shared Instance
    static let shared = MockHomeRepository()
    
    var shouldFail = false
    
    private init() {}
    
    func fetchTrendingRepositories(page: Int) async throws -> [GitHubRepo] {
        guard !shouldFail else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch error"]) as Error
        }
        
        guard let _ = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let _ = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
        
        do {
            let allRepos: [GitHubRepo] = try FileManager.loadJson(fileName: "Repositories")
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allRepos.count)
            
            guard startIndex < allRepos.count else {
                return []
            }
            
            try await Task.sleep(nanoseconds: 100_000_000)

            return Array(allRepos[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchRepositoryEvents(owner: String, name: String, page: Int) async throws -> [RepositoryEvent] {
        guard !shouldFail else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch error"]) as Error
        }
        
        guard let _ = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let _ = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
                
        do {
            let allEvents: [RepositoryEvent] = try FileManager.loadJson(fileName: "Events")
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allEvents.count)
            
            guard startIndex < allEvents.count else {
                return []
            }
            
            try await Task.sleep(nanoseconds: 100_000_000)

            return Array(allEvents[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
}
