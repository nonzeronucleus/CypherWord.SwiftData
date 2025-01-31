import SwiftData
import CoreData

class LevelExporter {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    private static func filePath() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
    }
    
    
    
    func getTileName(isLevel:Bool) -> String {
        switch(isLevel) {
            case true:
                return "Level.json"
            case false:
                return "Layout.json"
        }
    }
    

    func exportToJSON(isLevel:Bool) {
        let levels = fetchLevels(isLevel: isLevel)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let path = try LevelExporter.filePath() .appendingPathComponent(getTileName(isLevel:isLevel))
            
            print(path)
            
            let jsonData = try encoder.encode(levels)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                try jsonString.write(toFile: path.path, atomically: true, encoding: .utf8)
            }
        } catch {
            print("Failed to encode entities to JSON: \(error)")
        }
    }
    
    private func fetchLevels(isLevel:Bool) -> [Level] {
        let fetchDescriptor = FetchDescriptor<Level>(
            predicate: #Predicate { $0.isLevel == isLevel },
            sortBy: [SortDescriptor(\.levelNumber, order: .forward)]
        )
        
        do {
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }
    
    
    func importFromJSON(isLevel:Bool) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let path = try LevelExporter.filePath() .appendingPathComponent(getTileName(isLevel: isLevel))
            
            let jsonData = try Data(contentsOf: path)
            
            let levels = try decoder.decode([Level].self, from: jsonData)
            
            // Insert each decoded Level object into the ModelContext
            for level in levels {
                modelContext.insert(level)
            }

            // Save the context to persist the imported data
            try modelContext.save()
        } catch {
            print("Faield to decode entities from JSON: \(error)")
        }

    }
}
