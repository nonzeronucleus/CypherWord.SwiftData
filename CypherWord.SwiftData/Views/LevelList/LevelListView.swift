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
            
//            List(levels) { level in
//                Text("Level \(level.levelNumber), \(level.isLevel ? "Level" : "Layout")")
//            }
            
            HStack {
                Button("Add " + (isLevel ? "Level":"Layout")) {
                    let newLevel = Level(id: UUID(), levelNumber: nextLevelNumber(), levelGridText: "", isLevel: isLevel)
                    modelContext.insert(newLevel)
                    try? modelContext.save()
                }
                .padding()
                
//                Button("Save") {
//                    do {
//                        try modelContext.save()
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
                Button("Reset") {
                    do {
                        try modelContext.delete(model: Level.self)
                        try? modelContext.save()
                    }
                    catch {
                        print(error)
                    }
                }
                .padding()


            }
            
            
//            ScrollView {
//                LazyVStack {
//                    ForEach((0...10), id: \.self) {row in
//                        HStack {
//                            ForEach((1...4), id: \.self) {col in
//                                CartoonButton(levelNumber: row*4 + col) {
//                                    print("Level 1 Selected")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
        }
    }
    
    
    
//    
//    let descriptor = FetchDescriptor<Recipe>(
//        predicate: #Predicate { $0.isFavorite == true },
//        sortBy: [
//            .init(\.createdAt)
//        ]
//    )
//    
    
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

//#Preview {
//    var selectedLevel:Level? = nil
//    LevelListView(isLevel: true, selectedLevel: $selectedLevel)
//        .modelContainer(for: Level.self, inMemory: true)
//}

