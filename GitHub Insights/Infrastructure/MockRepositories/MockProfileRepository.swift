//
//  MockProfileRepository.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

final class MockProfileRepository: ProfileRepositoryProtocol {
    
    /// Shared Instance
    static let shared = MockProfileRepository()
    
    var shouldFail = false
    
    private init() {}
    
    func getUser() async throws -> User {
        guard !shouldFail else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch error"]) as Error
        }
        
        guard let _ = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let _ = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        return User.MOCK_USER
    }
    
    func fetchUserRepositories(page: Int) async throws -> [GitHubRepo] {
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
            
            return Array(allRepos[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchStarredRepositories(page: Int) async throws -> [GitHubRepo] {
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
    
    func fetchOrganizations(page: Int) async throws -> [Organization] {
        guard !shouldFail else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch error"]) as Error
        }
        
        guard let _ = UserDefaults.standard.object(forKey: "GITHUB_USERNAME") as? String,
              let _ = SecretsManager.shared.getToken() else {
            throw NetworkError.unauthorized
        }
        
        do {
            let allOrgs: [Organization] = try FileManager.loadJson(fileName: "Organizations")
            
            let startIndex = (page - 1) * 10
            let endIndex = min(startIndex + 10, allOrgs.count)
            
            guard startIndex < allOrgs.count else {
                return []
            }
            
            try await Task.sleep(nanoseconds: 100_000_000)
            
            return Array(allOrgs[startIndex..<endIndex])
        } catch {
            print(error)
            throw error
        }
    }
}
