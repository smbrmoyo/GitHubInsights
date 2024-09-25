//
//  HomeView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(repository: HomeRepository.shared)
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.repositories.isEmpty && viewModel.uiState == .idle {
                    RefreshableScrollView(items: viewModel.repositories,
                                          canRefresh: $viewModel.canRefresh,
                                          uiState: viewModel.uiState,
                                          spacing: 4) {
                        await viewModel.fetchRepositories()
                    } row:  { repository in
                        RepositoryRowView(gitHubRepo: repository)
                    }
                } else if viewModel.repositories.isEmpty && viewModel.uiState == .loading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.repositories.isEmpty && viewModel.uiState == .idle {
                    Text("No Items yet.")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .task {
                await viewModel.fetchRepositories()
            }
            .searchable(text: .constant(""))
            .toolbarTitleDisplayMode(.inline)
            .customToolbar("Trending") {
                Image(systemName: "flame")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: MockHomeRepository.shared))
}
