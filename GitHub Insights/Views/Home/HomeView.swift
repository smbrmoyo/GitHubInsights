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
            RefreshableScrollView(items: viewModel.repositories,
                                  canRefresh: $viewModel.canRefresh,
                                  uiState: viewModel.uiState,
                                  spacing: 4,
                                  emptyText: "No repositories found.") {
                await viewModel.fetchRepositories()
            } row:  { repository in
                RepositoryRowView(gitHubRepo: repository)
            }
            .toolbar("Trending") {
                ZStack {
                    Color.purple
                    
                    Image(systemName: "flame")
                        .foregroundStyle(.white)
                }
                .frame(width: 30, height: 30)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: MockHomeRepository.shared))
}
