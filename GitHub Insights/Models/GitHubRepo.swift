//
//  GitHubRepo.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

struct GitHubRepo: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var description: String? = ""
    var language: String? = ""
    var stargazersCount: Int = 0
    var owner: RepoOwner = .DEFAULT_REPO_OWNER
    
    static let MOCK_GITHUB_REPO = GitHubRepo(id: 123,
                                             name: "BallermapSwiftUI",
                                             description: "The Ballermap App written in SwiftUI",
                                             language: "Swift",
                                             stargazersCount: 0,
                                             owner: RepoOwner.MOCK_REPO_OWNER)
}

struct FetchGitHubRepoResponse: Codable {
    let items: [GitHubRepo]
}
