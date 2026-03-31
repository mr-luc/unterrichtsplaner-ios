import Foundation

enum PlanStatus: String, Codable, CaseIterable, Identifiable {
    case geplant
    case inArbeit = "in-arbeit"
    case fertig

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .geplant: return "Geplant"
        case .inArbeit: return "In Arbeit"
        case .fertig: return "Fertig"
        }
    }
    
    var symbolName: String {
        switch self {
        case .geplant: return "circle.fill"
        case .inArbeit: return "clock.fill"
        case .fertig: return "checkmark.circle.fill"
        }
    }
}
