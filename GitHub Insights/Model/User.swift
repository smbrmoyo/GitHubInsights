//
//  User.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

struct User: Codable, Equatable {
    let id, followers, following: Int
    let login, name, location, company, blog, bio: String
    
    static let DEFAULTUSER: User = .init(id: 0,
                                         followers: 0,
                                         following: 0,
                                         login: "",
                                         name: "",
                                         location: "",
                                         company: "", blog: "",
                                         bio: "")
}
