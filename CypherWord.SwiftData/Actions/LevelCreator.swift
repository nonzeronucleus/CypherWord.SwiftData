import Foundation
import SwiftData

class LevelCreator {
    var isLevel:Bool
    var modelContext: ModelContext
    var crossword:Crossword?
    
    init(isLevel:Bool, modelContext: ModelContext, crossword:Crossword? = nil) {
        self.isLevel = isLevel
        self.modelContext = modelContext
        self.crossword = crossword
    }
    
    
    func createLevel() {
        var levelGridText:String = ""
        
        if let crossword = crossword {
            let transformer = CrosswordTransformer()
            if let tempString = transformer.transformedValue(crossword) as? String {
                levelGridText = tempString
            }
        }
        
        let newLevel = Level(id: UUID(), levelNumber: nextLevelNumber(), levelGridText: levelGridText, isLevel: isLevel)
        modelContext.insert(newLevel)
        try? modelContext.save()
    }
    
    func nextLevelNumber() -> Int {
        let fetchRequest = FetchDescriptor<Level>(
            predicate: #Predicate { $0.isLevel == isLevel },
            sortBy: [SortDescriptor(\.levelNumber, order: .reverse)])
        
        do {
            if let highestLevel = try modelContext.fetch(fetchRequest).first {
                return highestLevel.levelNumber + 1
            } else {
                return 1 // Default to 1 if no levels exist
            }
        } catch {
            print("Error fetching levels: \(error)")
            return 1
        }
    }
}
