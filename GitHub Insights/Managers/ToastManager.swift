//
//  ToastManager.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

@MainActor
final class ToastManager: ObservableObject {
    
    // MARK: - Properties
    
    static let shared: ToastManager = ToastManager()
    @Published var toast: Toast?
    
    // MARK: - Lifecycle
    
    private init() {}
    
    
    // MARK: - Functions
    
    func createToast(_ toast: Toast) {
        self.toast = toast
    }
}
