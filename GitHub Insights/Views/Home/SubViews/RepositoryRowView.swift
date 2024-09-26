//
//  RepositoryRowView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import SwiftUI

struct RepositoryRowView: View {
    let gitHubRepo: GitHubRepo
    
    var body: some View {
        NavigationLink {
            RepositoryDetailView(gitHubRepo: gitHubRepo,
                                 viewModel: RepositoryDetailViewModel(
                                    repository: HomeRepository.shared,
                                    gitHubRepo: gitHubRepo))
        } label: {
            VStack(alignment: .leading) {
                
                HStack {
                    NetworkImageView(imageURL: gitHubRepo.owner.avatarUrl,
                                     size: 30,
                                     cornerRadius: 5)
                    
                    VStack(alignment: .leading) {
                        Text(gitHubRepo.owner.login)
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                }
                
                Text(gitHubRepo.name)
                    .font(.title2)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                if ((gitHubRepo.description?.isEmpty) == nil) {
                    Text(gitHubRepo.description ?? "")
                        .font(.callout)
                        .padding(.vertical, 2)
                }
                
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "star")
                    
                    Text("\(gitHubRepo.stargazersCount)")
                        .font(.title3)
                        .padding(.trailing)
                    
                    if (gitHubRepo.language != nil && !gitHubRepo.language.orEmpty.isEmpty) {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(GitHubLanguage(rawValue: gitHubRepo.language.orEmpty)?.color ?? .gray)
                        
                        Text(gitHubRepo.language.orEmpty)
                            .font(.title3)
                    }
                }
                .foregroundStyle(.gray)
            }
            .padding()
            .background(Color.background)
        }
        
    }
}

#Preview {
    RepositoryRowView(gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO)
}
