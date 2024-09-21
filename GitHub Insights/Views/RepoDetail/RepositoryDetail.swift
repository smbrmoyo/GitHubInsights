//
//  RepositoryDetail.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import SwiftUI

struct RepositoryDetail: View {
    let gitHubRepo: GitHubRepo
    @StateObject var viewModel: RepositoryDetailViewModel
    
    var body: some View {
        ScrollView {
            RepositoryHeaderView(gitHubRepo: gitHubRepo)
            
            LazyVStack(alignment: .leading) {
                Text("Activity")
                    .font(.title)
                
                if viewModel.uiState == .loading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .frame(height: 500)
                } else {
                    ForEach(viewModel.repositoryActivities) { activity in
                        HStack {
                            Text(activity.activityType.rawValue)
                        }
                        .padding()
                        .background(Color.background)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            await viewModel.fetchRepositoryActivity()
        }
    }
}

#Preview {
    RepositoryDetail(gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO,
                     viewModel: RepositoryDetailViewModel(repository: MockHomeRepository.shared,
                                                          gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO))
}
