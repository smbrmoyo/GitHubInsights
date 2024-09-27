//
//  Organization.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import Foundation

struct Organization: Codable, Equatable, Identifiable {
    let id: Int
    let login, avatarUrl: String
    var description: String?
    
    static let EMPTY_ORGANIZATION: Organization = .init(id: 0,
                                                        login: "",
                                                        avatarUrl: "",
                                                        description: "")
    
    static let MOCK_ORGANIZATION: Organization = .init(id: 123,
                                                        login: "BallerMap",
                                                        avatarUrl: "https://avatars.githubusercontent.com/u/167162964?v=4",
                                                        description: "A great organization.")
}
