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

//    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        ZStack {
             if selectedLevel == nil {
                 TabsView(selectedLevel: $selectedLevel)
                     .transition(.move(edge: .leading)) // Slide in from the left
             } else {
                 EditorView(selectedLevel: $selectedLevel)
                     .transition(.move(edge: .trailing)) // Slide in from the right
             }
         }
         .animation(.easeInOut(duration: 0.4), value: selectedLevel) // Animate the transition
     }
//        NavigationStack {
//            if selectedLevel != nil {
//                // Navigate to ChildViewB when selectedLevel is set
//                ChildViewB(selectedLevel: $selectedLevel)
//            } else {
//                // Display ChildViewA when selectedLevel is nil
//                TabsView(selectedLevel: $selectedLevel)
//            }
//        }
//    }

        
//        NavigationStack(path: $navigationPath) {
////            VStack(spacing: 40) {
////                ForEach(screens, id: \.self) { screen in
////                    NavigationLink(value: screen) {
////                        Text(screen.rawValue)
////                    }
////                }
////            }
//            .navigationTitle("Main View")
//            .navigationDestination(for: NavigationDestinations.self) { screen in
//                switch screen {
//                    case .List:
//                        TabsView(selectedLevel: $selectedLevel)
//                    case .Details:
//                        ChildViewB(selectedLevel: $selectedLevel)
//                }
//            }
//        }
//    }
}
