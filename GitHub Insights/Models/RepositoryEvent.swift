//
//  RepositoryEvent.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 23.09.24.
//

import Foundation

struct RepositoryEvent: Codable, Identifiable, Hashable {    
    var id = "0"
    var type: RepositoryEventType? = .publicEvent
    var actor: Actor = Actor()
    var createdAt: String = ""
    
    struct Actor: Codable, Hashable {
        var id = 0
        var login = ""
        var avatarUrl = ""
    }
    
    static let MOCK_REPOSITORY_EVENT: [RepositoryEvent] = [
        .init(id: "1", type: .push, createdAt: "2024-09-17T14:22:00Z"),
        .init(id: "2", type: .pullRequest, createdAt: "2024-09-16T10:12:00Z"),
        .init(id: "3", type: .issues, createdAt: "2024-09-15T09:55:00Z"),
        .init(id: "4", type: .fork, createdAt: "2024-09-14T08:35:00Z"),
        .init(id: "5", type: .create, createdAt: "2024-09-13T07:20:00Z"),
        .init(id: "6", type: .delete, createdAt: "2024-09-12T12:10:00Z"),
        .init(id: "7", type: .release, createdAt: "2024-09-11T14:45:00Z"),
        .init(id: "8", type: .publicEvent, createdAt: "2024-09-10T16:25:00Z"),
        .init(id: "9", type: .push, createdAt: "2024-09-09T18:30:00Z"),
        .init(id: "10", type: .pullRequest, createdAt: "2024-09-08T20:15:00Z")
    ]
}
