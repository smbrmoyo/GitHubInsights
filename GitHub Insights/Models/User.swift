//
//  User.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

struct User: Codable, Equatable {
    let id, followers, following, publicRepos: Int
    let login, name, avatarUrl, twitterUsername, location, company, blog, bio: String
    
    static let EMPTY_USER: User = .init(id: 0,
                                          followers: 0,
                                          following: 0,
                                          publicRepos: 0,
                                          login: "",
                                          name: "",
                                          avatarUrl: "",
                                          twitterUsername: "",
                                          location: "",
                                          company: "",
                                          blog: "",
                                          bio: "")
    
    static let MOCK_USER: User = .init(id: 123,
                                       followers: 123,
                                       following: 321,
                                       publicRepos: 17,
                                       login: "smbrmoyo",
                                       name: "Brian Moyou",
                                       avatarUrl: "https://avatars.githubusercontent.com/u/74922712?v=4",
                                       twitterUsername: "brianmoyou1",
                                       location: "Dortmund, Germany",
                                       company: "Syntax Institut",
                                       blog: "ballermap.com",
                                       bio: "The more I look, the more I see.")
}
