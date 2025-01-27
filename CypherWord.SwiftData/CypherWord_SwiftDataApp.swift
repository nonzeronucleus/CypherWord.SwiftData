//
//  CypherWord_SwiftDataApp.swift
//  CypherWord.SwiftData
//
//  Created by Ian Plumb on 26/01/2025.
//

import SwiftUI
import SwiftData
import Combine
import CoreData

@main
struct CypherWord_SwiftDataApp: App {

    
    var sharedModelContainer: ModelContainer = {
        var cancellable: AnyCancellable?

        let schema = Schema([
            Item.self,
            Level.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        
        
        func observeSaves() {
            cancellable = NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification)
                .sink { notification in
                    print("Save notification received: \(notification)")
                }
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
