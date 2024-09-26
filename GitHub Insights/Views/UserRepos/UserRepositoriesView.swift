//
//  UserRepositoriesView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 23.09.24.
//

import SwiftUI

struct UserRepositoriesView: View {
    @StateObject var viewModel = UserRepositoriesViewModel(repository: ProfileRepository.shared)
    
    var body: some View {
        RefreshableScrollView(items: viewModel.repositories,
                              canRefresh: $viewModel.canRefresh,
                              uiState: viewModel.uiState,
                              spacing: 4,
                              emptyText: "No repositories found.") {
            await viewModel.fetchUserRepositories()
        } row: { repository in
            RepositoryRowView(gitHubRepo: repository)
        }
        .toolbar("Your Repositories")
    }
}

#Preview {
    NavigationStack {
        UserRepositoriesView(viewModel: UserRepositoriesViewModel(repository: MockProfileRepository.shared))
    }
}
