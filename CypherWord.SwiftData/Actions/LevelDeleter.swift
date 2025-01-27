import Foundation
import SwiftData

class LevelDeleter {
    var modelContext: ModelContext
    var isLevel: Bool
    
    init(modelContext: ModelContext, isLevel: Bool) {
        self.modelContext = modelContext
        self.isLevel = isLevel
    }
    
    func deleteLevels() throws {
        // Define a FetchDescriptor to find all Levels with isLevel = true
        let fetchDescriptor = FetchDescriptor<Level>(
            predicate: #Predicate { $0.isLevel == isLevel },
            sortBy: [SortDescriptor(\.levelNumber, order: .forward)]
        )
        
        do {
            // Fetch the levels to be deleted
            let levelsToDelete = try modelContext.fetch(fetchDescriptor)

            // Delete each object from the context
            for level in levelsToDelete {
                modelContext.delete(level)
            }

            // Save changes to persist the deletions
            try modelContext.save()
            print("Deleted \(levelsToDelete.count) levels where isLevel = true")
//        } catch {
//            print("Failed to delete levels: \(error)")
        }
    }
}

