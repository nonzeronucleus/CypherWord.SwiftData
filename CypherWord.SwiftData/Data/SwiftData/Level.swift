import Foundation
import SwiftData

@Model
final class Level {
    var id: UUID
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
}
