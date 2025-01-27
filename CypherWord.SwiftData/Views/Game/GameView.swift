import SwiftUI

struct GameView: View {
    @Binding var selectedLevel : Level?
    @State var showingConfirmation: Bool = false
    @State var backgroundColor: Color = .white
    @State var crossword : Crossword
    @State var letterValues:CharacterIntMap?
    @State var hasChanged: Bool = false
    @Environment(\.modelContext) private var modelContext
    @State var isPopulated: Bool = false
    

    init(selectedLevel: Binding<Level?>) {
        self._selectedLevel = selectedLevel
        var crossword:Crossword? = nil
        
        if let level = selectedLevel.wrappedValue {
            let transformer = CrosswordTransformer()
            
            if !level.levelGridText.isEmpty {
                crossword = transformer.reverseTransformedValue(level.levelGridText) as? Crossword ?? Crossword(rows: 15, columns: 15)
            }
        }
        
        self.crossword = crossword ?? Crossword(rows: 15, columns: 15)
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
                    ZStack {
                        CrosswordView(grid: crossword, viewMode: .actualValue, performAction: { id in toggleCell(id: id) })
                            .frame(width: geometry.size.width * 0.98, height: geometry.size.width * 0.98) // Lock height to 75% of the screen
                            .border(.gray)
                            .padding(.top,10)
                    }

                    Spacer()
                }
                .confirmationDialog("Save changes?",
                                    isPresented: $showingConfirmation) {
                    Text("Save Changes?")
                    Button("Save and exit", role: .none) {
                        save()
                        exit()
                    }
                    Button("Exit without saving", role: .destructive) {
                        exit()
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button("Go Back") {
                        handleBackButtonTap()
                    }
                    
                    Spacer()

                    Button("Save") {
                        save()
                    }
                    
                    Spacer()

                    Button("Generate") {
                        generate()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

extension GameView {
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
            hasChanged = true
        }
    }
    
    func handleBackButtonTap() {
        if hasChanged {
            showingConfirmation = true
        }
        else {
            exit()
        }
    }
    
    func exit() {
        showingConfirmation = false
        selectedLevel = nil
    }
    
    func save() {
        if isPopulated {
            saveLevel()
        }
        else {
            saveLayout()
        }
    }
    
    func saveLayout() {
        let transformer = CrosswordTransformer()
        
        if let levelGridText = transformer.transformedValue(crossword) as? String, let selectedLevel {
            selectedLevel.levelGridText = levelGridText
            try? modelContext.save()
            hasChanged = false
        }
    }
    
    func saveLevel() {
        let creator = LevelCreator(isLevel: true, modelContext: modelContext, crossword: crossword)
        creator.createLevel()
    }
    
    func generate() {
        let populator = CrosswordPopulator(crossword: crossword)
        
        let populated = populator.populateCrossword()
        
        crossword = populated.crossword
        
        letterValues = populated.characterIntMap
        isPopulated = true
        
    }
}
