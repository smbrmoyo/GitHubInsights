//
//  OrganizationViewModel.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 26.09.24.
//

import Foundation

class OrganizationsViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let repository: ProfileRepositoryProtocol
    
    // MARK: - Properties
    
    @Published var organizations: [Organization] = []
    @Published var uiState = UIState.idle
    @Published var isRefreshing = false
    @Published var canRefresh = true
    private var page = 1
    
    // MARK: - Lifecycle
    
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    @MainActor
    func fetchOrganizations() async {
        do {
            uiState = organizations.isEmpty ?  .loading : .idle
            let result = try await repository.fetchOrganizations(page: page)
            
            guard !result.isEmpty else {
                uiState = .idle
                canRefresh = false
                return
            }
            
            organizations.append(contentsOf: result)
            page += 1
            uiState = .idle
        } catch {
            uiState = .idle
            ToastManager.shared.createToast(Toast(style: .error, message: "No Organizations found."))
        }
    }
}
