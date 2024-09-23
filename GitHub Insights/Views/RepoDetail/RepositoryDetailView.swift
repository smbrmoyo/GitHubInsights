//
//  RepositoryDetailView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import SwiftUI

struct RepositoryDetailView: View {
    let gitHubRepo: GitHubRepo
    @StateObject var viewModel: RepositoryDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            RepositoryHeaderView(gitHubRepo: gitHubRepo)
            
            Text("Activity")
                .font(.title)
                .padding(.horizontal)
            
            RefreshableScrollView(items: viewModel.repositoryEvents,
                                  loadMoreItems: {await viewModel.fetchRepositoryEvents()}) { event in
                EventRowView(event: event)
            }
        }
        .task {
            await viewModel.fetchRepositoryEvents()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(gitHubRepo.name)
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    RepositoryDetailView(gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO,
                         viewModel: RepositoryDetailViewModel(
                            repository: MockHomeRepository.shared,
                            gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO
                         ))
}
