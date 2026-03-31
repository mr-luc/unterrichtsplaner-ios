import Foundation

struct PlanState {
    var klasse: String
    var thema: String
    var notiz: String
    var status: Fortschritt
}

enum Fortschritt: String, CaseIterable {
    case offen
    case inArbeit
    case fertig
}
