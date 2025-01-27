typealias Crossword = Grid2D<Cell>

extension Crossword {
    init(rows: Int, columns: Int) {
        self.init(rows: rows, columns: columns, elementGenerator: { row, col in Cell(pos: Pos(row: row, column: col)) })
    }
    
    init(initString:[String]) {
        let rows = initString.count
        let columns = initString[0].count
        self.init(rows: rows, columns: columns) {
            row, col in
                Cell(pos: Pos(row: row, column: col), configChar: initString[row][col])
        }
    }
    
    mutating func reset() {
        for rowIndex in elements.indices {
            for colIndex in elements[rowIndex].indices {
                var elem = elements[rowIndex][colIndex]
                elem.reset()
                self[rowIndex,colIndex] = elem
            }
        }
    }
    
    var isPopulated: Bool {
        for element in self.listElements() {
            if element.letter == " " {
                return false
            }
        }
        return true
    }
    
//    mutating func setLetterValues(_ letterValues: [Character: Int] ) {
//        self.letterValues = CharacterIntMap(letterValues)
//    }
}
