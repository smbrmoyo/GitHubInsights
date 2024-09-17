//
//  RefreshableScrollView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import SwiftUI

struct RefreshableScrollView<T: Identifiable, Content: View>: View {
    var items: [T]
    @State private var isRefreshing = false
    var loadMoreItems: () async -> ()
    var row: (T) -> Content
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    row(item)
                }
                
                if isRefreshing {
                    ProgressView()
                        .padding()
                } else {
                    GeometryReader { reader -> Color in
                        let minY = reader.frame(in: .global).minY
                        let height = UIScreen.main.bounds.height
                        
                        if minY < height {
                            DispatchQueue.main.async {
                                refresh()
                            }
                        }
                        return Color.clear
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
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
                          loadMoreItems: {},
                          row: { item in RepositoryRowView(repository: item) })
}
