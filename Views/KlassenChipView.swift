import SwiftUI

struct KlassenChipView: View {
    let eintrag: StundenEintragVorgabe

    var color: Color {
        switch eintrag.fach {
        case "Bio": return .green
        case "Che": return .cyan
        case "IT": return .purple
        default: return .gray
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(eintrag.klasse)
                    .font(.caption)
                    .bold()
                Spacer()
                Circle()
                    .fill(Color.gray)
                    .frame(width: 6, height: 6)
            }

            Text("\(eintrag.fach) · \(eintrag.raum)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(6)
        .background(color.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
