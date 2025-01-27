import SwiftUI

struct CrosswordView: View {
    var grid: Grid2D<Cell>
    var letterValues: CharacterIntMap?
    let performAction: (UUID) -> Void
    let viewMode: ViewMode
    let selectedNumber:Int?
    let checking:Bool
    let attemptedletterValues: [Character]?
    
    init(grid: Grid2D<Cell>,
         viewMode: ViewMode,
         letterValues: CharacterIntMap? = nil,
         selectedNumber:Int? = nil ,
         attemptedletterValues: [Character]? = nil,
         checking:Bool = false,
         performAction: @escaping (UUID) -> Void)
    {
        self.grid = grid
        self.viewMode = viewMode
        self.letterValues = letterValues
        self.selectedNumber = selectedNumber
        self.attemptedletterValues = attemptedletterValues
        self.checking = checking
        self.performAction = performAction
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ForEach(grid.getRows(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { cell in
                            var checkingStatus:CellView.Status = .normal
                            var number:Int? = nil
                            
                            var letter = cell.letter
                            
                            if let letterValues, let letter {
                                number = letterValues[letter]
                            }
                            
                            if let number, let attemptedletterValues {
                                if viewMode == .attemptedValue && letter != nil {
                                    letter = attemptedletterValues[number]
                                }
                                
                                if checking && letter != " " {
                                    if attemptedletterValues[number] == cell.letter {
                                        checkingStatus = .correct
                                    }
                                    else {
                                        checkingStatus = .incorrect
                                    }
                                }
                            }
//
                            return CellView(letter:letter,
                                            number: number,
                                            selected:number == selectedNumber,
                                            checkStatus: checkingStatus)
                                .onTapGesture {
                                    performAction(cell.id)
                                }
                        }
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .border(.green)
            .background(content: { Color.gray.opacity(0.2) })
        }
    }
}

#Preview("Attempted Value blank") {
    var crossword = Grid2D(rows: 15, columns: 15, elementGenerator: { row, column in
        Cell(pos: Pos(row: row, column: column))
    })
    
    crossword[0, 0].letter = "A"
//    crossword[0, 0].toggle()

    return CrosswordView(grid: crossword, viewMode: .attemptedValue,  performAction: { _ in } )
        .padding(.all, 10)
}

#Preview("Actual Value") {
    var crossword = Grid2D(rows: 10, columns: 10, elementGenerator: { row, column in
        Cell(pos: Pos(row: row, column: column))
    })
    
    crossword[0, 0].letter = "A"

//    crossword[0, 0].toggle()

//    CrosswordView(grid: crossword, viewMode: .actualValue, performAction: { _ in })
    return CrosswordView(grid: crossword, viewMode: .actualValue, performAction: { _ in })
        .padding(.all, 10)
}
