import SwiftUI

@MainActor
enum PDFExportService {
    /// Rendert den Stundenplan als PDF und gibt die temporäre URL zurück.
    /// Die Datei liegt in `tmp/` und kann direkt an einen `UIActivityViewController` übergeben werden.
    static func exportiere(wocheTyp: String, montag: Date) async -> URL? {
        let pdfView = StundenplanPDFView(wocheTyp: wocheTyp, montag: montag)
        let renderer = ImageRenderer(content: pdfView)
        // A4 Querformat in Punkten (72 dpi)
        renderer.proposedSize = .init(width: 842, height: 595)

        let dateiname = dateinameAktuell(wocheTyp: wocheTyp, montag: montag)
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(dateiname)

        var erfolgreich = false
        renderer.render { groesse, zeichne in
            var rect = CGRect(origin: .zero, size: groesse)
            guard let ctx = CGContext(url as CFURL, mediaBox: &rect, nil) else { return }
            ctx.beginPDFPage(nil)
            zeichne(ctx)
            ctx.endPDFPage()
            ctx.closePDF()
            erfolgreich = true
        }

        return erfolgreich ? url : nil
    }

    private static func dateinameAktuell(wocheTyp: String, montag: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "de_DE")
        f.dateFormat = "yyyy-MM-dd"
        return "Stundenplan_Woche\(wocheTyp)_\(f.string(from: montag)).pdf"
    }
}
