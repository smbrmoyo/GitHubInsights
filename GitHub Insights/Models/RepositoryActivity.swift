//
//  RepositoryActivity.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import Foundation

struct RepositoryActivity: Codable, Identifiable {
    var id: Int = 0
    var nodeId: String = ""
    var timestamp: String = ""
    var activityType: RepositoryActivityType = .push
    
    static let MOCK_REPO_ACTIVITY = [
        RepositoryActivity(
            id: 20267693742,
            nodeId: "PSH_kwLOMuLXVc8AAAAEuAx2rg",
            timestamp: "2024-09-17T02:27:59Z",
            activityType: .push
        ),
        RepositoryActivity(
            id: 20267693743,
            nodeId: "PSH_kwLOMuLXVc8AAAAEuAx2rh",
            timestamp: "2024-09-16T12:45:32Z",
            activityType: .forcePush
        ),
        RepositoryActivity(
            id: 20267693744,
            nodeId: "PSH_kwLOMuLXVc8AAAAEuAx2rk",
            timestamp: "2024-09-15T11:23:11Z",
            activityType: .branchCreation
        ),
        RepositoryActivity(
            id: 20267693745,
            nodeId: "PSH_kwLOMuLXVc8AAAAEuAx2rl",
            timestamp: "2024-09-14T16:09:08Z",
            activityType: .branchDeletion
        ),
        RepositoryActivity(
            id: 20267693746,
            nodeId: "PSH_kwLOMuLXVc8AAAAEuAx2rm",
            timestamp: "2024-09-13T10:30:50Z",
            activityType: .prMerge
        )
    ]
}
