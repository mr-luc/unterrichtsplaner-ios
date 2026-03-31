import Foundation

struct WochenService {
    static let referenzMontag = Calendar.current.date(from: DateComponents(year: 2026, month: 3, day: 23))!

    static func aktuellerMontag(offset: Int = 0) -> Date {
        let heute = Date()
        let weekday = Calendar.current.component(.weekday, from: heute)
        let diff = weekday == 1 ? -6 : 2 - weekday
        let montag = Calendar.current.date(byAdding: .day, value: diff + offset * 7, to: heute)!
        return Calendar.current.startOfDay(for: montag)
    }

    static func wocheTyp(for montag: Date) -> String {
        let diff = Calendar.current.dateComponents([.weekOfYear], from: referenzMontag, to: montag).weekOfYear ?? 0
        return diff % 2 == 0 ? "B" : "A"
    }
}
