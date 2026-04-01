import Foundation

class PlanRepository: ObservableObject {
    @Published var daten: [String: PlanEintrag] = [:]

    func eintrag(fach: String, klasse: String) -> PlanEintrag {
        let key = "\(fach)_\(klasse)"
        return daten[key] ?? PlanEintrag(fach: fach, klasse: klasse)
    }

    func speichern(_ eintrag: PlanEintrag) {
        daten[eintrag.key] = eintrag
    }
}
