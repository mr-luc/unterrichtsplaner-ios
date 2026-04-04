import SwiftUI

struct StundenplanGridView: View {
    let tage = StundenKonfiguration.tage
    let stunden = StundenKonfiguration.alle
    let aktuelleWoche = WochenService.wocheTyp(for: WochenService.aktuellerMontag())

    @State private var pdfURL: URL?
    @State private var zeigeShareSheet = false
    @State private var exportLaeuft = false

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: 8) {
                headerRow

                ForEach(stunden) { stunde in
                    VStack(spacing: 6) {
                        row(for: stunde)

                        if stunde.pauseDanach {
                            Text("Pause")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Stundenplan")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                exportButton
            }
        }
        .sheet(isPresented: $zeigeShareSheet) {
            if let url = pdfURL {
                ShareSheet(activityItems: [url])
            }
        }
    }

    @ViewBuilder
    private var exportButton: some View {
        if exportLaeuft {
            ProgressView()
        } else {
            Button {
                Task {
                    exportLaeuft = true
                    let montag = WochenService.aktuellerMontag()
                    pdfURL = await PDFExportService.exportiere(
                        wocheTyp: aktuelleWoche,
                        montag: montag
                    )
                    exportLaeuft = false
                    zeigeShareSheet = pdfURL != nil
                }
            } label: {
                Label("Als PDF exportieren", systemImage: "square.and.arrow.up")
            }
        }
    }

    private var headerRow: some View {
        HStack(spacing: 8) {
            Color.clear
                .frame(width: 72, height: 44)

            ForEach(tage, id: \.self) { tag in
                Text(tag)
                    .font(.headline)
                    .frame(width: 130, height: 44)
                    .background(.primary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private func row(for stunde: StundeZeit) -> some View {
        HStack(spacing: 8) {
            VStack(spacing: 2) {
                Text("\(stunde.nummer)")
                    .font(.headline)
                Text("\(stunde.von)\n\(stunde.bis)")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 72, minHeight: 72)
            .padding(4)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary.opacity(0.15), lineWidth: 1)
            )

            ForEach(tage, id: \.self) { tag in
                cell(for: tag, stunde: stunde.nummer)
            }
        }
    }

    private func cell(for tag: String, stunde: Int) -> some View {
        let eintraege = StundenDaten.eintraege.filter {
            $0.tag == tag &&
            $0.stunde == stunde &&
            ($0.woche == "AB" || $0.woche == aktuelleWoche)
        }

        return VStack(alignment: .leading, spacing: 6) {
            if eintraege.isEmpty {
                Spacer()
            } else {
                ForEach(eintraege) { eintrag in
                    KlassenChipView(eintrag: eintrag)
                }
                Spacer(minLength: 0)
            }
        }
        .frame(width: 130, minHeight: 72, alignment: .topLeading)
        .padding(6)
        .background(eintraege.isEmpty ? Color(.secondarySystemBackground) : Color(.systemBackground).opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.secondary.opacity(0.12), lineWidth: 1)
        )
    }
}
