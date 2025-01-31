import SwiftUI
import SwiftData

struct LevelListView: View {
    @Binding var selectedLevel:Level?
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Environment(\.modelContext) private var modelContext
    @State private var isLevel: Bool
    @Query private var levels: [Level]
    
    
    init(isLevel: Bool, selectedLevel: Binding<Level?>) {
        self._selectedLevel = selectedLevel
        let fetchRequest = FetchDescriptor<Level>(
            predicate: #Predicate { $0.isLevel == isLevel },
            sortBy: [SortDescriptor(\.levelNumber, order: .forward)])
        _levels = Query(fetchRequest)
        
        self.isLevel = isLevel
    }
    
    var body: some View {
        VStack {
            Text(isLevel ? "Level":"Layout")
                .frame(maxWidth: .infinity)
                .padding(CGFloat(integerLiteral: 32))
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .background(Color.blue)
            
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(levels) { level in
                        CartoonButton(levelNumber:level.levelNumber) {
                            selectedLevel = level
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button("Export") {
                    let exporter = LevelExporter(modelContext: modelContext)
                    exporter.exportToJSON(isLevel:isLevel)
                }
                Button("Import") {
                    let exporter = LevelExporter(modelContext: modelContext)
                    exporter.importFromJSON(isLevel:isLevel)
                }
                if !isLevel {
                    Button("Add Layout") {
                        let creator = LevelCreator(isLevel: isLevel, modelContext: modelContext)
                        creator.createLevel()
                    }
                    .padding()
                }
                
                Button("Delete "+(isLevel ? "Levels":"Layouts")) {
                    do {
                        let levelDeleter = LevelDeleter(modelContext: modelContext, isLevel: isLevel)
                        
                        try levelDeleter.deleteLevels()
//                        try modelContext.delete(model: Level.self)
//                        try? modelContext.save()
                    }
                    catch {
                        print(error)
                    }
                }
                .padding()
            }
        }
    }
}
    

//#Preview {
//    var selectedLevel:Level? = nil
//    LevelListView(isLevel: true, selectedLevel: $selectedLevel)
//        .modelContainer(for: Level.self, inMemory: true)
//}

