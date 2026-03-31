import SwiftUI

struct StundenChip: View {
    var title: String
    var color: Color

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(color.opacity(0.3))
            .cornerRadius(10)
    }
}
