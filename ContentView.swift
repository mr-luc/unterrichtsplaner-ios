import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            KlassenView()
                .tabItem {
                    Label("Klassen", systemImage: "person.3")
                }

            PlanungView()
                .tabItem {
                    Label("Planung", systemImage: "calendar")
                }

            NotizenView()
                .tabItem {
                    Label("Notizen", systemImage: "note.text")
                }
        }
    }
}
