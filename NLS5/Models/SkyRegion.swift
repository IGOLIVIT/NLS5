import Foundation

struct SkyRegion: Identifiable {
    let id: Int
    let name: String
    let mood: String
    let difficulty: SkyDifficulty
    let levelRange: ClosedRange<Int>

    var levelIds: [Int] { Array(levelRange) }
    var firstLevelId: Int { levelRange.lowerBound }

    static let all: [SkyRegion] = [
        SkyRegion(
            id: 1,
            name: "Quiet Horizon",
            mood: "Simple star paths, calm sky, beginner constellations",
            difficulty: .beginner,
            levelRange: 1...8
        ),
        SkyRegion(
            id: 2,
            name: "Golden Meridian",
            mood: "Warmer golden star maps with longer routes",
            difficulty: .easy,
            levelRange: 9...16
        ),
        SkyRegion(
            id: 3,
            name: "Emerald Orbit",
            mood: "Green orbital accents, branching constellations",
            difficulty: .medium,
            levelRange: 17...24
        ),
        SkyRegion(
            id: 4,
            name: "Silent Nebula",
            mood: "Darker clouds, more stars, less obvious routes",
            difficulty: .hard,
            levelRange: 25...32
        ),
        SkyRegion(
            id: 5,
            name: "Crown of Night",
            mood: "Final celestial region, complex star patterns",
            difficulty: .expert,
            levelRange: 33...40
        )
    ]

    static func region(for levelId: Int) -> SkyRegion? {
        all.first { $0.levelRange.contains(levelId) }
    }
}
