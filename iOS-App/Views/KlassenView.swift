import SwiftUI

struct KlassenView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Klasse 5a")
                Text("Klasse 6b")
            }
            .navigationTitle("Klassen")
        }
    }
}
