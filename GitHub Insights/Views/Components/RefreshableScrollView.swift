//
//  RefreshableScrollView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import SwiftUI

struct RefreshableScrollView<T: Identifiable, Content: View>: View {
    
    // MARK: - Properties
    
    var items: [T]
    @State private var isRefreshing = false
    @Binding var canRefresh: Bool
    var uiState: UIState
    var spacing: CGFloat = 0
    var loadMoreItems: () async -> ()
    @ViewBuilder var row: (T) -> Content
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if !items.isEmpty && uiState == .idle {
                ScrollView {
                    LazyVStack(spacing: spacing) {
                        ForEach(items) { item in
                            row(item)
                        }
                        
                        if canRefresh {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    refresh()
                                }
                        }
                    }
                }
            } else if items.isEmpty && uiState == .loading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if items.isEmpty && uiState == .idle {
                Text("No Events yet.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            await loadMoreItems()
        }
    }
    
    // MARK: - Funktionen
    
    private func refresh() {
        guard !isRefreshing else { return }
        
        Task {
            isRefreshing = true
            await loadMoreItems()
            isRefreshing = false
        }
    }
}

#Preview {
    RefreshableScrollView(items: [GitHubRepo.MOCK_GITHUB_REPO],
                          canRefresh: .constant(false),
                          uiState: .idle,
                          loadMoreItems: {},
                          row: { item in RepositoryRowView(gitHubRepo: item) })
}
