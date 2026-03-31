import Foundation

struct StundenEintragVorgabe: Identifiable {
    let id = UUID()
    let stunde: Int
    let tag: String
    let fach: String
    let klasse: String
    let raum: String
    let woche: String
}

struct StundenDaten {
    static let eintraege: [StundenEintragVorgabe] = [
        .init(stunde: 1, tag: "MO", fach: "Bio", klasse: "R10a", raum: "207", woche: "AB"),
        .init(stunde: 2, tag: "MO", fach: "Bio", klasse: "R10b", raum: "207", woche: "AB"),
        .init(stunde: 3, tag: "MO", fach: "IT", klasse: "R6a", raum: "PC-RS", woche: "AB"),
        .init(stunde: 4, tag: "MO", fach: "IT", klasse: "W7b", raum: "PC-RS", woche: "AB"),
        .init(stunde: 1, tag: "DI", fach: "Che", klasse: "W8a", raum: "Wi MNT", woche: "AB"),
        .init(stunde: 5, tag: "DI", fach: "IT", klasse: "W7a", raum: "PC-RS", woche: "AB"),
        .init(stunde: 4, tag: "MI", fach: "IT", klasse: "R6c", raum: "PC-WRS", woche: "AB"),
        .init(stunde: 1, tag: "DO", fach: "Bio", klasse: "W10", raum: "Wi MNT", woche: "AB"),
        .init(stunde: 7, tag: "DO", fach: "IT", klasse: "R8a", raum: "PC-RS", woche: "AB"),
        .init(stunde: 4, tag: "FR", fach: "Bio", klasse: "W8b", raum: "Wi MNT", woche: "AB")
    ]
}
