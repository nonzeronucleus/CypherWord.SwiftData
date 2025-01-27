import SwiftUI


enum Tab: String, CaseIterable, Identifiable {
    case level
    case layout

    var id: Self { self }
}

struct TabsView: View {
    @Binding var selectedLevel:Level?
    @State var selection = Tab.layout

    var body: some View {
        TabView(selection: $selection) {
            LevelListView(isLevel: true, selectedLevel:$selectedLevel)
                .tabItem {
                    Image(systemName: "books.vertical")
                     Text("Levels")
                 }
                .tag(Tab.level)
            LevelListView(isLevel: false, selectedLevel:$selectedLevel)
                .tabItem {
                    Image(systemName: "person")
                     Text("Layout")
                 }
                .tag(Tab.layout)
        }
    }
}
