//
//  ProfileView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel(repository: ProfileRepository.shared)
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.uiState == .loading {
                    ProgressView()
                } else if viewModel.uiState == .idle {
                    ProfileViewLoaded(user: viewModel.user)
                }
            }
            .toolbar("Profile", content:  {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showLogOutSheet = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            })
            .sheet(isPresented: $viewModel.showLogOutSheet) {
                ProfileSheet()
            }
            .task {
                await viewModel.getUser()
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(repository: MockProfileRepository.shared))
}
