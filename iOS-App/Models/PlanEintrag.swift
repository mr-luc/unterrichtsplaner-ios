import Foundation

struct PlanEintrag: Identifiable, Hashable {
    var id: String { key }
    let key: String
    let fach: String
    let klasse: String
    var thema: String
    var notiz: String
    var status: PlanStatus

    init(fach: String, klasse: String, thema: String = "", notiz: String = "", status: PlanStatus = .geplant) {
        self.key = "\(fach)_\(klasse)"
        self.fach = fach
        self.klasse = klasse
        self.thema = thema
        self.notiz = notiz
        self.status = status
    }
}
