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
        NavigationStack {
            VStack {
                if !viewModel.repositories.isEmpty && viewModel.uiState == .idle {
                    RefreshableScrollView(items: viewModel.repositories,
                                          canRefresh: $viewModel.canRefresh,
                                          uiState: viewModel.uiState,
                                          spacing: 4,
                                          loadMoreItems: { await viewModel.fetchUserRepositories() },
                                          row: { repository in
                        RepositoryRowView(gitHubRepo: repository)
                    })
                } else if viewModel.repositories.isEmpty && viewModel.uiState == .loading {
                    ProgressView()
                }
            }
            .searchable(text: .constant(""))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Your Repositories")
                            .font(.title)
                    }
                }
            }
        }
    }
}
#Preview {
    UserRepositoriesView(viewModel: UserRepositoriesViewModel(repository: MockProfileRepository.shared))
}
