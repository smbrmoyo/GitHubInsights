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
        ScrollView {
            Text("hey")
        }
        .onAppear {
            viewModel.fetchRepositories()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: MockHomeRepository.shared))
}
