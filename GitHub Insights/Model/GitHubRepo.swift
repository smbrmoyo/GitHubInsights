//
//  GitHubRepo.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

struct GitHubRepo: Codable {
    let id: Int
    let name: String
    
    static let DEFAULT_GITHUB_REPO = GitHubRepo(id: 0, name: "")
    
    static let MOCK_GITHUB_REPO = GitHubRepo(id: 123, name: "BallerMap")
}

struct FetchGitHubRepoResponse: Codable {
    let items: [GitHubRepo]
}
