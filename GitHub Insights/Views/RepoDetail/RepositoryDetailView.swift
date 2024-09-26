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
            
            HStack{}
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .background(Color.background)
            
            Text("Activity")
                .font(.title)
                .padding(.horizontal)
            
            RefreshableScrollView(items: viewModel.repositoryEvents,
                                  canRefresh: $viewModel.canRefresh,
                                  uiState: viewModel.uiState,
                                  spacing: 4,
                                  emptyText: "No Events found.") {
                await viewModel.fetchRepositoryEvents()
            } row: { event in
                EventRowView(event: event)
            }
        }
        .toolbar(gitHubRepo.name)
    }
}

#Preview {
    NavigationStack {
        RepositoryDetailView(gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO,
                             viewModel: RepositoryDetailViewModel(
                                repository: MockHomeRepository.shared,
                                gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO
                             ))
    }
}
