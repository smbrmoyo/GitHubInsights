//
//  PersistentStore.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 07.09.24.
//

import CoreData

class PersistentStore {
    
    static let shared = PersistentStore()
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "GitHub_Insights")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            print("Datenbank geladen")
        }
    }
}
