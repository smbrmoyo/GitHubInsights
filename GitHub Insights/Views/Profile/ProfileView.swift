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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .onAppear {
                viewModel.getUser()
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(repository: MockProfileRepository.shared))
}
