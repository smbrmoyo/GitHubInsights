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
                                          loadMoreItems: { await viewModel.fetchRepositories() },
                                          row: { repository in
                        RepositoryRowView(gitHubRepo: repository)
                    })
                } else if viewModel.repositories.isEmpty && viewModel.uiState == .loading {
                    ProgressView()
                }
            }
            .task {
                await viewModel.fetchRepositories()
            }
            .searchable(text: .constant(""))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Trending")
                            .font(.title)
                        
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
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: MockHomeRepository.shared))
}
