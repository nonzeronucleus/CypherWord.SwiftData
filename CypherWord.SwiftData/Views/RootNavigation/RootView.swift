import SwiftUI


//
//struct ChildViewB: View {
//    @Binding var selectedLevel : Level?
//    @State private var isContentVisible = false // Control the animation
//    
//    var body: some View {
//        VStack {
//            if let selectedLevel {
//                Text(selectedLevel.isLevel ? "Level":"Layout")
//                    .frame(maxWidth: .infinity)
//                    .padding(CGFloat(integerLiteral: 32))
//                    .font(.system(size: 32, weight: .bold, design: .rounded))
//                    .background(Color.blue)
//            }
//            
//            if let selectedLevel {
//                Text("Selected Level: \(selectedLevel.levelNumber)")
//            }
//            
//            Spacer()
//            
//            Button("Go Back") {
//                selectedLevel = nil
//            }
//        }
//        .navigationTitle("ChildViewB")
//        .onAppear {
//            isContentVisible = true // Animate when the view appears
//        }
//        .onDisappear {
//            isContentVisible = false // Reset for next navigation
//        }
//    }
//
//}

struct RootView: View {
    @State var selectedLevel : Level? = nil
    @State var selection:Tab = .level

//    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        ZStack {
            if let selectedLevel {
                if selectedLevel.isLevel {
                    GameView(selectedLevel: $selectedLevel)
                        .transition(.move(edge: .trailing))
                }
                else {
                    EditorView(selectedLevel: $selectedLevel)
                        .transition(.move(edge: .trailing)) // Slide in from the right
                }
            }
            else {
                TabsView(selectedLevel: $selectedLevel, selection: $selection)
                     .transition(.move(edge: .leading)) // Slide in from the left
             }
         }
//         .animation(.easeInOut(duration: 0.4), value: selectedLevel) // Animate the transition
     }
}
