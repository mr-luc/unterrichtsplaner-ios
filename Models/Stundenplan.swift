import Foundation
import SwiftData

@Model
final class StundenEintrag {
    var id: UUID
    var wochentag: Int
    var stunde: Int
    var klasse: String
    var fach: String
    var thema: String
    var notiz: String
    var farbcode: String
    var istFerien: Bool

    init(
        id: UUID = UUID(),
        wochentag: Int,
        stunde: Int,
        klasse: String,
        fach: String,
        thema: String = "",
        notiz: String = "",
        farbcode: String = "blue",
        istFerien: Bool = false
    ) {
        self.id = id
        self.wochentag = wochentag
        self.stunde = stunde
        self.klasse = klasse
        self.fach = fach
        self.thema = thema
        self.notiz = notiz
        self.farbcode = farbcode
        self.istFerien = istFerien
    }
}
