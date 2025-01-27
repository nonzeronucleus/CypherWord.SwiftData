//import SwiftUI
//
//
//class Router: ObservableObject {
//    // Contains the possible destinations in our Router
//    enum Route: Hashable {
//        case viewA
//        case viewB(String)
//        case viewC
//        case levelList
//    }
//    
//    // Used to programatically control our navigation stack
//    @Published var path: NavigationPath = NavigationPath()
//    
//    // Builds the views
//    @ViewBuilder func view(for route: Route) -> some View {
//        switch route {
//        case .viewA:
//            ViewA()
//        case .viewB(let str):
//            ViewB(description: str)
//        case .viewC:
//            ViewC()
//        case .levelList:
//            LevelListView(isLevel: true)
//
//        }
//    }
//    
//    // Used by views to navigate to another view
//    func navigateTo(_ appRoute: Route) {
//        path.append(appRoute)
//    }
//    
//    // Used to go back to the previous screen
//    func navigateBack() {
//        path.removeLast()
//    }
//    
//    // Pop to the root screen in our hierarchy
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
//}
//
//struct ViewA: View {
//    @EnvironmentObject var router: Router
//    
//    var body: some View {
//        VStack() {
//            Button("Go to View B") {
//                router.navigateTo(.viewB("Got here from A"))
//            }
//            Button("Go to Level List") {
//                router.navigateTo(.levelList)
//            }
//        }
//        .navigationTitle("View A")
//    }
//}
//
//struct ViewB: View {
//    @EnvironmentObject var router: Router
//    let description: String
//    
//    var body: some View {
//        VStack() {
//            Text(description)
//            Button("Go to View A") {
//                router.navigateTo(.viewA)
//            }
//            Button("Go to View C") {
//                router.navigateTo(.viewC)
//            }
//        }
//        .navigationTitle("View B")
//    }
//}
//
//struct ViewC: View {
//    @EnvironmentObject var router: Router
//    
//    var body: some View {
//        VStack() {
//            Button("Go to View B") {
//                router.navigateTo(.viewB("Got here from C"))
//            }
//            Button("Go back") {
//                router.navigateBack()
//            }
//        }
//        .navigationTitle("View C")
//    }
//}
//
