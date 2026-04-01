import SwiftUI

struct StundenplanGrid: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 5)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<25, id: \.self) { index in
                StundenChip(title: "Klasse", color: .blue)
            }
        }
        .padding()
    }
}
