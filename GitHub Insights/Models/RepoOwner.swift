//
//  RepoOwner.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import Foundation

struct RepoOwner: Codable, Equatable {
    let id: Int
    let login, avatarUrl, type, url: String
    
    static let EMPTY_REPO_OWNER = RepoOwner(id: 0,
                                              login: "",
                                              avatarUrl: "",
                                              type: "",
                                              url: "")
    
    static let MOCK_REPO_OWNER = RepoOwner(id: Int.random(in: 1...9999),
                                           login: "BallerMap",
                                           avatarUrl: "https://avatars.githubusercontent.com/u/167162964?v=4",
                                           type: "Organization",
                                           url: "https://api.github.com/users/BallerMap")
}
