import Foundation

struct ConstellationLevel: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let regionId: Int
    let difficulty: SkyDifficulty
    let stars: [StarPoint]
    let correctRoute: [Int]
    let hasAtlasFragment: Bool

    var unlockRequirement: Int? {
        id == 1 ? nil : id - 1
    }

    var connections: [StarConnection] {
        var result: [StarConnection] = []
        for i in 0..<(correctRoute.count - 1) {
            result.append(StarConnection(from: correctRoute[i], to: correctRoute[i + 1]))
        }
        return result
    }
}
