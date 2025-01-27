import Foundation
//import Dependencies

struct Cell: Equatable, Identifiable, Hashable, Codable, Grid2DItem  {
    let id: UUID
    let pos: Pos
    var letter:Character?
    
//    var attemptedLetter:Character = " "
    
    init(pos:Pos, letter:Character? = nil) {
//        @Dependency(\.uuid) var uuid
//        self.id = uuid()   //UUID()
        self.id = UUID()
        self.letter = letter
        self.pos = pos
    }
    
    // Create cell based on a config, where the "." character represents a nil char
    // Primarily for testing purposes
    init(pos:Pos, configChar:Character ) {
        let letter = configChar == "." ? nil : configChar

        self.init(pos:pos, letter:letter)
    }
    
    mutating func reset() {
        if letter != nil {
            letter = " "
        }
    }

    
    mutating func toggle() {
        if letter == nil {
            letter = " "
        }
        else {
            letter = nil
        }
    }
    
//    static var dummy: Cell { Cell(letter:"X") }
    
    enum CodingKeys: String, CodingKey {
        case id, letter, number, pos
    }
    
    func toStorable() -> Character {
        return letter ?? "."
    }
    
    var isActive: Bool {
        letter != nil
    }

    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: Cell.CodingKeys.id)
        self.pos = try container.decode(Pos.self, forKey: .pos)
        if let letterString = try container.decodeIfPresent(String.self, forKey: .letter) {
            letter = letterString.first // Decode a single character from a string
        } else {
            letter = nil
        }
//        number = try container.decodeIfPresent(Int.self, forKey: .number)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(pos, forKey: .pos)
        try container.encode(letter.map { String($0) }, forKey: .letter) // Encode character as string
//        try container.encode(number, forKey: .number)
    }
}
