//
//  ProfileHeader.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct ProfileHeader: View {
    let user: User
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue, .green, .yellow, .orange]), startPoint: .leading, endPoint: .trailing)
                .frame(width: 350, height: 200)
                .opacity(0.2)
            
            VStack(alignment: .leading) {
                HStack {
                    NetworkImageView(imageURL: user.avatarUrl)
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title2)
                        Text(user.login)
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 4)
                    
                    Spacer()
                }
                
                Text(user.bio)
                    .font(.title3)
                    .padding(.vertical)
                    .lineLimit(3)
                    .truncationMode(.tail)
                
                HStack {
                    if !user.company.isEmpty {
                        Label(user.company, systemImage: "building.2")
                            .foregroundStyle(.gray)
                    }
                    
                    if !user.location.isEmpty {
                        Label(user.location, systemImage: "map")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.vertical, 1)
                
                HStack {
                    if !user.location.isEmpty {
                        Image(systemName: "link")
                            .foregroundStyle(.gray)
                        Text(user.blog)
                    }
                    
                    if !user.twitterUsername.isEmpty {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                        Text("@\(user.twitterUsername)")
                    }
                }
                .padding(.vertical, 1)
                
                HStack(spacing: 4) {
                    Image(systemName: "person.2")
                        .foregroundStyle(.gray)
                    Text("\(user.followers)")
                    Text("followers")
                        .foregroundStyle(.gray)
                    
                    Text("•")
                        .foregroundStyle(.gray)
                    
                    Text(" \(user.following)" )
                    Text("following")
                        .foregroundStyle(.gray)
                    
                }
                .padding(.vertical, 1)
            }
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    ProfileHeader(user: User.MOCK_USER)
}
