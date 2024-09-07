//
//  GitHub_InsightsApp.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 07.09.24.
//

import SwiftUI

@main
struct GitHub_InsightsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
