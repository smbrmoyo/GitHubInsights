//
//  SecretsManager.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

final class SecretsManager {
    
    /// Shared Instance
    static let shared = SecretsManager()
    
    private init() {}
    
    func getToken() -> String? {
        if let url = Bundle.main.url(forResource: "Secrets", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
            return json["GITHUB_TOKEN"]
        }
        return nil
    }
}
