//
//  ProfileNavigationRow.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 15.09.24.
//

import SwiftUI

struct ProfileNavigationRow<Content: View>: View {
    let title: String
    let icon: String
    let background: Color
    let number: String
    let destination: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{}
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .background(Color.background)
            
            NavigationLink {
                
            } label: {
                HStack {
                    ZStack {
                        background
                        
                        Image(systemName: icon)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 30, height: 30)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text(title)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    HStack {
                        Text(number)
                            .foregroundStyle(.gray)
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                .background(.ultraThickMaterial)
            }
            
            HStack{}
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
                .background(Color.background)
        }
    }
}

#Preview {
    ProfileNavigationRow(title: "Public Repositories", icon: "book", background: .gray, number: "17", destination: EmptyView())
}
#Preview {
    ProfileNavigationRow(title: "Public Repositories", icon: "book", background: .gray, number: "", destination: EmptyView())
}
