import SwiftUI

/// Sauberes, fixes Layout für PDF-Export – kein ScrollView, A4-Querformat (842 × 595 pt)
struct StundenplanPDFView: View {
    let tage = StundenKonfiguration.tage
    let stunden = StundenKonfiguration.alle
    let wocheTyp: String
    let montag: Date

    private let zellBreite: CGFloat = 130
    private let zeitSpalteBreite: CGFloat = 64
    private let zellHoehe: CGFloat = 52

    var body: some View {
        VStack(spacing: 0) {
            kopfzeile
            Divider()
            tabelle
        }
        .padding(16)
        .frame(width: 842, height: 595)
        .background(Color.white)
    }

    private var kopfzeile: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Stundenplan – Woche \(wocheTyp)")
                    .font(.title2).bold()
                Text("Schulzentrum Oberes Elztal · \(montagFormatiert)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "books.vertical.fill")
                .font(.title)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }

    private var tabelle: some View {
        VStack(spacing: 2) {
            // Tageskopf
            HStack(spacing: 4) {
                Color.clear.frame(width: zeitSpalteBreite)
                ForEach(tage, id: \.self) { tag in
                    Text(tag)
                        .font(.subheadline).bold()
                        .frame(width: zellBreite)
                        .padding(.vertical, 4)
                        .background(Color.black)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }

            // Stundenzeilen
            ForEach(stunden) { stunde in
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        // Zeitspalte
                        VStack(spacing: 1) {
                            Text("\(stunde.nummer)")
                                .font(.headline)
                            Text("\(stunde.von)\n\(stunde.bis)")
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                        }
                        .frame(width: zeitSpalteBreite, height: zellHoehe)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                        // Tageszellen
                        ForEach(tage, id: \.self) { tag in
                            pdfZelle(tag: tag, stunde: stunde.nummer)
                        }
                    }

                    if stunde.pauseDanach {
                        HStack {
                            Color.clear.frame(width: zeitSpalteBreite)
                            Text("— Pause —")
                                .font(.system(size: 7))
                                .foregroundStyle(Color.secondary.opacity(0.6))
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func pdfZelle(tag: String, stunde: Int) -> some View {
        let eintraege = StundenDaten.eintraege.filter {
            $0.tag == tag && $0.stunde == stunde &&
            ($0.woche == "AB" || $0.woche == wocheTyp)
        }

        VStack(alignment: .leading, spacing: 2) {
            if eintraege.isEmpty {
                Spacer()
            } else {
                ForEach(eintraege) { e in
                    HStack(spacing: 3) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(fachFarbe(e.fach))
                            .frame(width: 3)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(e.klasse)
                                .font(.system(size: 9, weight: .bold))
                            Text("\(e.fach) · \(e.raum)")
                                .font(.system(size: 8))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .frame(width: zellBreite, height: zellHoehe, alignment: .topLeading)
        .padding(4)
        .background(
            eintraege.isEmpty
                ? Color(.systemGray6)
                : fachFarbe(eintraege.first!.fach).opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.15), lineWidth: 0.5)
        )
    }

    private func fachFarbe(_ fach: String) -> Color {
        switch fach {
        case "Bio": return .green
        case "Che": return .cyan
        case "IT":  return .purple
        default:    return .gray
        }
    }

    private var montagFormatiert: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "de_DE")
        f.dateStyle = .long
        return f.string(from: montag)
    }
}
