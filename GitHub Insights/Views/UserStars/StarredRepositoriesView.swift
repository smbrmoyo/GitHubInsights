//
//  StarredRepositoriesView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 25.09.24.
//

import SwiftUI

struct StarredRepositoriesView: View {
    @StateObject var viewModel = StarredRepositoriesViewModel(repository: ProfileRepository.shared)
    
    var body: some View {
        RefreshableScrollView(items: viewModel.repositories,
                              canRefresh: $viewModel.canRefresh,
                              uiState: viewModel.uiState,
                              spacing: 4,
                              emptyText: "No Starred Repositories found.") {
            await viewModel.fetchStarredRepositories()
        } row: { repository in
            RepositoryRowView(gitHubRepo: repository)
        }
        .toolbar("Your Starred Repos")
    }
}

#Preview {
    NavigationStack {
        StarredRepositoriesView(viewModel: StarredRepositoriesViewModel(repository: MockProfileRepository.shared))
    }
}
