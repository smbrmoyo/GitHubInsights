//
//  OrganizationsView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import SwiftUI

struct OrganizationsView: View {
    @StateObject var viewModel = OrganizationsViewModel(repository: ProfileRepository.shared)
    
    var body: some View {
        RefreshableScrollView(items: viewModel.organizations,
                              canRefresh: $viewModel.canRefresh,
                              uiState: viewModel.uiState,
                              emptyText: "No Organizations found.") {
            await viewModel.fetchOrganizations()
        } row: { organization in
            OrganizationRowView(organization: organization)
        }
        .toolbar("Your Organizations")
    }
}

#Preview {
    NavigationStack {
        OrganizationsView(viewModel: OrganizationsViewModel(repository: MockProfileRepository.shared))
    }
}
