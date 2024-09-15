//
//  ProfileViewLoaded.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct ProfileViewLoaded: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProfileHeader(user: user)
                
                ProfileNavigationRow(title: "Public Repositories", icon: "book", background: .gray, number: "\(user.publicRepos)", destination: EmptyView())
                
                ProfileNavigationRow(title: "Starred", icon: "star", background: .yellow, number: "", destination: EmptyView())
                
                ProfileNavigationRow(title: "Organizations", icon: "building.2", background: .orange, number: "", destination: EmptyView())
            }
        }
    }
}

#Preview {
    ProfileViewLoaded(user: User.MOCK_USER)
        .background(.black)
}
