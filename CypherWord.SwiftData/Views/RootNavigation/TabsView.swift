import SwiftUI


enum Tab: String, CaseIterable, Identifiable {
    case level
    case layout

    var id: Self { self }
}

struct TabsView: View {
    @Binding var selectedLevel:Level?
    @Binding var selection:Tab

    init(selectedLevel: Binding<Level?>, selection:  Binding<Tab>) {
        self._selection = selection
        self._selectedLevel = selectedLevel
    }

    var body: some View {
        
        Text("\(selection)")
        
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
