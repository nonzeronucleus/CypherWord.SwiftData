import SwiftUI

struct GameView: View {
//    @Binding var selectedLevel : Level?
//    @State var crossword : Crossword
    @Environment(\.modelContext) private var modelContext
    
    init(selectedLevel: Binding<Level?>) {
    }
    
    var body: some View {
        Text("GameView")
    }
}
