import Foundation
import SwiftData

@Model
final class Level: Codable  {
    @Attribute(.unique) var id: UUID
    var levelNumber: Int
    var levelGridText: String
    var isLevel: Bool // Yes if full level, no if just a layout
    var letterMap: String?
    
    init(id: UUID, levelNumber: Int, levelGridText: String, isLevel: Bool, letterMap: String? = nil) {
        self.id = id
        self.levelNumber = levelNumber
        self.isLevel = isLevel
        self.levelGridText = levelGridText
        self.letterMap = letterMap
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
         case id, levelNumber, levelGridText, isLevel, letterMap
     }

     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         self.id = try container.decode(UUID.self, forKey: .id)
         self.levelNumber = try container.decode(Int.self, forKey: .levelNumber)
         self.levelGridText = try container.decode(String.self, forKey: .levelGridText)
         self.isLevel = try container.decode(Bool.self, forKey: .isLevel)
         self.letterMap = try container.decodeIfPresent(String.self, forKey: .letterMap)
     }

     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(id, forKey: .id)
         try container.encode(levelNumber, forKey: .levelNumber)
         try container.encode(levelGridText, forKey: .levelGridText)
         try container.encode(isLevel, forKey: .isLevel)
         try container.encode(letterMap, forKey: .letterMap)
     }
}
