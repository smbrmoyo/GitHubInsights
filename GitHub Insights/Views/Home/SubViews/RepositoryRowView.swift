//
//  RepositoryRowView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: GitHubRepo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NetworkImageView(size: 30,
                                 cornerRadius: 5,
                                 imageURL: repository.owner.avatarUrl)
                
                VStack(alignment: .leading) {
                    Text(repository.owner.login)
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            
            Text(repository.name)
                .font(.title2)
            
            if ((repository.description?.isEmpty) == nil) {
                Text(repository.description ?? "")
                    .font(.callout)
                    .padding(.vertical, 2)
            }
                
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "star")
                
                Text("\(repository.stargazersCount)")
                    .font(.title3)
                    .padding(.trailing)
                
                if (repository.language != nil && !repository.language.orEmpty.isEmpty) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(GitHubLanguage(rawValue: repository.language.orEmpty)?.color ?? .gray)
                    
                    Text(repository.language.orEmpty)
                        .font(.title3)
                }
            }
            .foregroundStyle(.gray)
        }
        .padding()
        .background(Color.background)
    }
}

#Preview {
    RepositoryRowView(repository: GitHubRepo.MOCK_GITHUB_REPO)
}
