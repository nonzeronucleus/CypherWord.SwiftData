import SwiftUI

struct EditorView: View {
    @Binding var selectedLevel : Level?
    @State var crossword : Crossword
    @Environment(\.modelContext) private var modelContext

    init(selectedLevel: Binding<Level?>) {
        self._selectedLevel = selectedLevel
        var crossword:Crossword? = nil
        
        if let level = selectedLevel.wrappedValue {
            let transformer = CrosswordTransformer()
            
            if !level.levelGridText.isEmpty {
                crossword = transformer.reverseTransformedValue(level.levelGridText) as? Crossword ?? Crossword(rows: 15, columns: 15)
            }
        }
        
        if crossword == nil {
            crossword = Crossword(rows: 15, columns: 15)
        }
        
        self.crossword = crossword!
    }

    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                if let selectedLevel {
                    Text(selectedLevel.isLevel ? "Level":"Layout")
                        .frame(maxWidth: .infinity)
                        .padding(CGFloat(integerLiteral: 32))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .background(Color.blue)
                }
                
                VStack {
                    CrosswordView(grid: crossword, viewMode: .actualValue, performAction: { id in toggleCell(id: id) })
                        .frame(width: geometry.size.width * 0.98, height: geometry.size.width * 0.98) // Lock height to 75% of the screen
                        .border(.gray)
                        .padding(.top,10)

                    Spacer() // Push the rest down
                }
                
                
                if let selectedLevel {
                    Text("Selected Level: \(selectedLevel.levelNumber)")
                }
                
                Spacer()
                
                Button("Go Back") {
                    exit()
                }
            }
        }
    }
}

extension EditorView {
    func toggleCell(id: UUID) {
        if let location = crossword.locationOfElement(byID: id) {
            crossword.updateElement(byPos: location) { cell in
                cell.toggle()
            }
            let opposite = Pos(row: crossword.columns - 1 - location.row, column: crossword.rows - 1 - location.column)
            
            if opposite != location {
                crossword.updateElement(byPos: opposite) { cell in
                    cell.toggle()
                }
            }
        }
    }
    
    func exit() {
        let transformer = CrosswordTransformer()
        
        if let levelGridText = transformer.transformedValue(crossword) as? String, let selectedLevel {
            selectedLevel.levelGridText = levelGridText
            self.selectedLevel = nil
            try? modelContext.save()
        }

//        let transformer = CrosswordTransformer()
//        selectedLevel = nil
//        print("\(String(describing: transformer.transformedValue(crossword)))")
//        selectedLevel?.levelGridText =
    }
}
