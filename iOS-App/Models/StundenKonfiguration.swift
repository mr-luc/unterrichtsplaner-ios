import Foundation

struct StundeZeit: Identifiable {
    let id = UUID()
    let nummer: Int
    let von: String
    let bis: String
    let pauseDanach: Bool
}

struct StundenKonfiguration {
    static let alle: [StundeZeit] = [
        .init(nummer: 1, von: "07:30", bis: "08:15", pauseDanach: false),
        .init(nummer: 2, von: "08:15", bis: "09:00", pauseDanach: true),
        .init(nummer: 3, von: "09:15", bis: "10:00", pauseDanach: false),
        .init(nummer: 4, von: "10:00", bis: "10:45", pauseDanach: true),
        .init(nummer: 5, von: "11:05", bis: "11:50", pauseDanach: false),
        .init(nummer: 6, von: "11:50", bis: "12:35", pauseDanach: true),
        .init(nummer: 7, von: "13:15", bis: "14:00", pauseDanach: false),
        .init(nummer: 8, von: "14:00", bis: "14:45", pauseDanach: false),
        .init(nummer: 9, von: "14:45", bis: "15:30", pauseDanach: false)
    ]

    static let tage = ["MO", "DI", "MI", "DO", "FR"]
}
