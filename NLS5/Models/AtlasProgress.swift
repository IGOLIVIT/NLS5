import Foundation

struct LevelResult: Codable {
    var bestSkyMarks: Int
    var bestMistakes: Int
    var bestHints: Int
    var fragmentCollected: Bool
    var isPerfect: Bool
}
