//
//  RepositoryHeaderView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import SwiftUI

struct RepositoryHeaderView: View {
    let gitHubRepo: GitHubRepo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NetworkImageView(imageURL: gitHubRepo.owner.avatarUrl,
                                 size: 30,
                                 cornerRadius: 15)
                
                Text(gitHubRepo.owner.login)
                    .font(.title3)
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            
            HStack {
                Text(gitHubRepo.name)
                    .font(.title)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                HStack {
                    Text(gitHubRepo.visibility)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                }
                .background(Color.background)
                .clipped()
                .clipShape(Capsule())
            }
            
            if let description = gitHubRepo.description {
                Text(description)
                    .font(.title3)
                    .padding(.vertical, 2)
                    .lineLimit(3)
                    .truncationMode(.tail)
            }
            
            HStack(spacing: 4) {
                Image(systemName: "star")
                    .foregroundStyle(.gray)
                
                Text("\(gitHubRepo.stargazersCount)")
                Text("stars")
                    .foregroundStyle(.gray)
                
                Text("•")
                    .foregroundStyle(.gray)
                
                Image(systemName: "tuningfork")
                    .foregroundStyle(.gray)
                
                Text(" \(gitHubRepo.forks)" )
                Text("forks")
                    .foregroundStyle(.gray)
                
            }
            .padding(.vertical, 2)
            
            Text("Last Commit: \(Date.timeAgoSinceDate(gitHubRepo.pushedAt))")
                .padding(.top, 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    RepositoryHeaderView(gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO)
}
