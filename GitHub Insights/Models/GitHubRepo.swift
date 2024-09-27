//
//  GitHubRepo.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

struct GitHubRepo: Codable, Equatable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var description: String? = ""
    var language: String? = ""
    var stargazersCount: Int = 0
    var forks: Int = 0
    var watchers: Int = 0
    var size: Int = 0
    var owner: RepoOwner = .EMPTY_REPO_OWNER
    var pushedAt: String = ""
    var visibility: String = ""
    
    static let MOCK_GITHUB_REPO = GitHubRepo(id: 123,
                                             name: "BallermapSwiftUI",
                                             description: "The Ballermap App written in SwiftUI",
                                             language: "Swift",
                                             stargazersCount: 12,
                                             forks: 32,
                                             watchers: 1,
                                             size: 200,
                                             owner: RepoOwner.MOCK_REPO_OWNER,
                                             pushedAt: Date.now.ISO8601Format(),
                                             visibility: "private")
}

struct FetchGitHubRepoResponse: Codable {
    let items: [GitHubRepo]
}
