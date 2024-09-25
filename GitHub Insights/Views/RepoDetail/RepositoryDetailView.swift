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
                                  canRefresh: $viewModel.canRefresh,
                                  uiState: viewModel.uiState,
                                  spacing: 4) { 
                await viewModel.fetchRepositoryEvents()
            } row: { event in
                EventRowView(event: event)
            }
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
