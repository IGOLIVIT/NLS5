import Foundation

enum SkyDifficulty: String, Codable, CaseIterable, Hashable {
    case beginner = "Beginner"
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert"

    var displayName: String { rawValue }

    var starCount: String {
        switch self {
        case .beginner: return "4–5 stars"
        case .easy: return "6–7 stars"
        case .medium: return "7–9 stars"
        case .hard: return "9–11 stars"
        case .expert: return "10–12 stars"
        }
    }
}
