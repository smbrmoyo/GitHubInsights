//
//  EventRowView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 22.09.24.
//

import SwiftUI

struct EventRowView: View {
    let event: RepositoryEvent
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: event.type?.systemImage ?? "questionmark.app")
                    .frame(width: 30, height: 30)
                
                Text(event.type?.rawValue ?? "Unknown")
                    .font(.title)
                
                Spacer()
                
                Text(Date.timeAgoSinceDate(event.createdAt))
            }
            
            HStack {
                NetworkImageView(imageURL: event.actor.avatarUrl, size: 30, cornerRadius: 15)
                
                Text(event.actor.login)
                    .font(.title3)
                
                Text("authored")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background(Color.background)
    }
}

#Preview {
    EventRowView(event: RepositoryEvent.MOCK_REPOSITORY_EVENT.randomElement()!)
}
