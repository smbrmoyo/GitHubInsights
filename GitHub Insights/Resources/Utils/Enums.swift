//
//  Enums.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import SwiftUI

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case badGateway
    case serverError
    case serviceUnavailable
    case unknownError
    case custom(message: String)
}

enum Endpoint {
    
    private var baseUrl: String { "https://api.github.com" }
    
    case organizationRepositories(organizationName: String)
    case userRepositories(username: String)
    case events(owner: String, repo: String)
    case user(username: String)
    case search
    
    var urlString: String {
        switch self {
        case .organizationRepositories(organizationName: let orgName):
            return baseUrl + "/orgs/\(orgName)/repos"
            
        case .userRepositories(username: let username):
            return baseUrl + "/users/\(username)/repos"
            
        case .events(owner: let owner, repo: let repo):
            return baseUrl + "/repos/\(owner)/\(repo)/events"
            
        case .user(username: let username):
            return baseUrl + "/users/\(username)"
            
        case .search:
            return baseUrl + "/search/repositories"
        }
    }
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
    
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.blue
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

enum Tab {
    case home, profile
}

enum Regex: String {
    case email = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    case fullName = "^(?=.{3,20}$)(?!.*([\\s])\\1{2})[\\w\\s]+$"
    case username = "^@[a-zA-Z0-9]{3,15}$"
    case eventName = "^(?=.{3,25}$)(?!.*([\\s])\\1{2})[\\w\\s]+$"
}

enum UIState {
    case loading
    case idle
    case working
}

enum GitHubLanguage: String, CaseIterable, Codable {
    case Swift
    case Javascript = "JavaScript"
    case Python
    case Java
    case Ruby
    case Php = "PHP"
    case Go
    case Rust
    case Kotlin
    case Typescript = "TypeScript"
    case C
    case Cpp = "C++"
    case Html = "HTML"
    case Css = "CSS"
    case Shell
    case ObjectiveC = "Objective-C"
    
    var color: Color {
        switch self {
        case .Swift:
            return Color(hex: "#F05138")
        case .Javascript:
            return Color(hex: "#F1E05A")
        case .Python:
            return Color(hex: "#3572A5")
        case .Java:
            return Color(hex: "#B07219")
        case .Ruby:
            return Color(hex: "#701516")
        case .Php:
            return Color(hex: "#4F5D95")
        case .Go:
            return Color(hex: "#00ADD8")
        case .Rust:
            return Color(hex: "#DEA584")
        case .Kotlin:
            return Color(hex: "#A97BFF")
        case .Typescript:
            return Color(hex: "#2B7489")
        case .C:
            return Color(hex: "#555555")
        case .Cpp:
            return Color(hex: "#F34B7D")
        case .Html:
            return Color(hex: "#E34C26")
        case .Css:
            return Color(hex: "#563D7C")
        case .Shell:
            return Color(hex: "#89E051")
        case .ObjectiveC:
            return Color(hex: "#438EFF")
        }
    }
}

enum RepositoryActivityType: String, Codable {
    case push = "push"
    case forcePush = "force_push"
    case branchCreation = "branch_creation"
    case branchDeletion = "branch_deletion"
    case prMerge = "pr_merge"
    case mergeQueueMerge = "merge_queue_merge"
    
    var systemImage: String {
        switch self {
        case .push:
            return "arrow.up.circle.fill"
        case .forcePush:
            return "arrow.uturn.right.circle.fill"
        case .branchCreation:
            return "plus.circle.fill"
        case .branchDeletion:
            return "minus.circle.fill"
        case .prMerge:
            return "rectangle.stack.badge.plus"
        case .mergeQueueMerge:
            return "rectangle.stack.fill.badge.plus"
        }
    }
    
    var title: String {
        switch self {
        case .push:
            return "Push"
        case .forcePush:
            return "Force-Push"
        case .branchCreation:
            return "Branch Creation"
        case .branchDeletion:
            return "Branch Deletion"
        case .prMerge:
            return "PR-Merge"
        case .mergeQueueMerge:
            return "Merge-Queue-Merge"
        }
    }
}

enum RepositoryEventType: String, Codable {
    case push = "PushEvent"
    case pullRequest = "PullRequestEvent"
    case pullRequestReview = "PullRequestReviewEvent"
    case pullRequestReviewComment = "PullRequestReviewCommentEvent"
    case issues = "IssuesEvent"
    case issueComment = "IssueCommentEvent"
    case create = "CreateEvent"
    case delete = "DeleteEvent"
    case fork = "ForkEvent"
    case watch = "WatchEvent"
    case release = "ReleaseEvent"
    case member = "MemberEvent"
    case gollum = "GollumEvent"
    case publicEvent = "PublicEvent"
    case commitComment = "CommitCommentEvent"
    case branchProtectionRule = "BranchProtectionRuleEvent"
    case deployment = "DeploymentEvent"
    case deploymentStatus = "DeploymentStatusEvent"
    case status = "StatusEvent"
    case mergeQueueMerge = "MergeQueueMergeEvent"
    
    var systemImage: String {
        switch self {
        case .push:
            return "arrow.up.right.circle.fill"
        case .pullRequest:
            return "arrow.merge"
        case .pullRequestReview:
            return "checkmark.seal.fill"
        case .pullRequestReviewComment:
            return "text.bubble"
        case .issues:
            return "exclamationmark.circle.fill"
        case .issueComment:
            return "text.bubble.fill"
        case .create:
            return "plus.circle.fill"
        case .delete:
            return "trash.fill"
        case .fork:
            return "tuningfork"
        case .watch:
            return "eye.fill"
        case .release:
            return "tag.fill"
        case .member:
            return "person.fill"
        case .gollum:
            return "book.fill"
        case .publicEvent:
            return "globe"
        case .commitComment:
            return "text.append"
        case .branchProtectionRule:
            return "lock.shield.fill"
        case .deployment:
            return "rocket.fill"
        case .deploymentStatus:
            return "checkmark.circle.fill"
        case .status:
            return "hourglass"
        case .mergeQueueMerge:
            return "arrow.triangle.merge"
        }
    }
}


