//
//  OrganizationRowView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import SwiftUI

struct OrganizationRowView: View {
    let organization: Organization
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NetworkImageView(imageURL: organization.avatarUrl,
                                 size: 30,
                                 cornerRadius: 5)
                
                VStack(alignment: .leading) {
                    Text(organization.login)
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            
            Text(organization.login)
                .font(.title2)
            
            if ((organization.description?.isEmpty) == nil) {
                Text(organization.description ?? "")
                    .font(.callout)
                    .padding(.vertical, 2)
            }
        }
        .padding()
        .background(Color.background)
    }
}

#Preview {
    OrganizationRowView(organization: Organization.MOCK_ORGANIZATION)
}
