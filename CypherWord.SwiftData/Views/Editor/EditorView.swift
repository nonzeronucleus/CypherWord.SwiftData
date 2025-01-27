import SwiftUI

struct EditorView: View {
    @Binding var selectedLevel : Level?
//    @State private var isContentVisible = false // Control the animation
    
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
                    CrosswordView(grid: Grid2D(rows: 10, columns: 10), viewMode: .actualValue, performAction: { id in print("Tapped on cell with id: \(id)") })
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
                    selectedLevel = nil
                }
            }
//            .navigationTitle("ChildViewB")
//            .onAppear {
//                isContentVisible = true // Animate when the view appears
//            }
//            .onDisappear {
//                isContentVisible = false // Reset for next navigation
//            }
        }
    }
}
