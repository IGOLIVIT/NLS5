import Foundation

enum ConstellationLevelFactory {

    static func makeAllLevels() -> [ConstellationLevel] {
        return quietHorizon() + goldenMeridian() + emeraldOrbit() + silentNebula() + crownOfNight()
    }

    // MARK: - Region 1: Quiet Horizon (Levels 1–8, Beginner, 4–6 stars)

    private static func quietHorizon() -> [ConstellationLevel] {
        [
            ConstellationLevel(
                id: 1, title: "First Spark", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.25, y: 0.30, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.45, y: 0.48, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.62, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.78, y: 0.78, size: 1.2, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 2, title: "Soft Line", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.52, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.38, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.60, y: 0.44, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.82, y: 0.56, size: 1.1, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 3, title: "North Pair", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.28, y: 0.32, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.50, y: 0.22, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.72, y: 0.32, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.50, y: 0.52, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.50, y: 0.74, size: 1.2, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 4, title: "Gentle Arc", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.35, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.50, y: 0.30, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.65, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.82, y: 0.62, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 5, title: "Small Compass", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.20, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.78, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.50, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.22, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.50, y: 0.50, size: 1.2, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 6, title: "Pale Thread", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.38, y: 0.58, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.58, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.78, y: 0.58, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.88, y: 0.38, size: 1.1, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 7, title: "Dawn Trace", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.30, y: 0.52, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.44, y: 0.32, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.60, y: 0.42, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.74, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.86, y: 0.36, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 8, title: "Horizon Seal", regionId: 1, difficulty: .beginner,
                stars: [
                    StarPoint(id: 0, x: 0.30, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.18, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.38, y: 0.28, size: 1.1, isFragmentStar: true),
                    StarPoint(id: 3, x: 0.62, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.82, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.70, y: 0.72, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5],
                hasAtlasFragment: true
            )
        ]
    }

    // MARK: - Region 2: Golden Meridian (Levels 9–16, Easy, 6–7 stars)

    private static func goldenMeridian() -> [ConstellationLevel] {
        [
            ConstellationLevel(
                id: 9, title: "Amber Path", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.14, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.30, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.50, y: 0.20, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.66, y: 0.35, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.72, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.86, y: 0.72, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 10, title: "Sun Needle", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.34, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.20, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.34, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.60, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.76, y: 0.54, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 11, title: "Golden Turn", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.24, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.46, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.66, y: 0.28, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.76, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.60, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.38, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.20, y: 0.60, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 12, title: "Bright Meridian", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.28, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.50, y: 0.28, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.72, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.80, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.68, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.48, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.28, y: 0.66, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 13, title: "Warm Orbit", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.18, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.80, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.66, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.40, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.20, y: 0.66, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.24, y: 0.40, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 14, title: "Signal Star", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.28, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.54, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.76, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.76, y: 0.64, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.54, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.28, y: 0.66, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.50, size: 1.2, isFragmentStar: true)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 15, title: "Long Angle", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.14, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.30, y: 0.36, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.46, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.62, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.46, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.86, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.72, y: 0.76, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 16, title: "Meridian Gate", regionId: 2, difficulty: .easy,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.72, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.82, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.76, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.50, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.24, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.18, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.28, y: 0.24, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7],
                hasAtlasFragment: false
            )
        ]
    }

    // MARK: - Region 3: Emerald Orbit (Levels 17–24, Medium, 7–9 stars)

    private static func emeraldOrbit() -> [ConstellationLevel] {
        [
            ConstellationLevel(
                id: 17, title: "Green Axis", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.50, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.28, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.14, y: 0.66, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.34, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.50, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.66, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.86, y: 0.66, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 18, title: "Twin Orbit", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.24, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.40, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.56, y: 0.20, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.72, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.60, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.40, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.24, y: 0.56, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 19, title: "Silent Ring", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.76, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.86, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.72, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.46, y: 0.86, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 5, x: 0.20, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.14, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.28, y: 0.20, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 20, title: "Emerald Trace", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.34, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.54, y: 0.18, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.70, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.80, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.66, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.46, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.28, y: 0.66, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 21, title: "Threefold Star", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.66, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.82, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.76, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.60, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.50, y: 0.86, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.34, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.24, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.34, y: 0.30, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 22, title: "Hidden Curve", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.34, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.54, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.70, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.54, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.66, y: 0.72, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 6, x: 0.50, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.30, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.18, y: 0.56, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 23, title: "Orbit Key", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.86, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.82, y: 0.64, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.62, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.36, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.16, y: 0.64, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.18, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.34, y: 0.18, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 24, title: "Celestial Loop", regionId: 3, difficulty: .medium,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.82, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.70, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.50, y: 0.86, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.30, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.18, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.30, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.50, y: 0.50, size: 1.2, isFragmentStar: true)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                hasAtlasFragment: true
            )
        ]
    }

    // MARK: - Region 4: Silent Nebula (Levels 25–32, Hard, 9–11 stars)

    private static func silentNebula() -> [ConstellationLevel] {
        [
            ConstellationLevel(
                id: 25, title: "Dark Cloud", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.20, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.38, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.58, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.76, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.86, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.80, y: 0.58, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.64, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.44, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.24, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.14, y: 0.50, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 26, title: "Faint Pattern", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.86, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.90, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.50, y: 0.86, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.24, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.10, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.14, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.30, y: 0.14, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 27, title: "Mist Route", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.14, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.28, y: 0.32, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.18, y: 0.52, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.34, y: 0.66, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.50, y: 0.56, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 5, x: 0.66, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.82, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.76, y: 0.40, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.60, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.44, y: 0.34, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 28, title: "Broken Arc", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.28, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.14, y: 0.66, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.10, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.18, y: 0.26, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.38, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.60, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.76, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.82, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.66, y: 0.74, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.46, y: 0.76, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 29, title: "Deep Signal", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.66, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.82, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.90, y: 0.42, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.56, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.66, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.46, y: 0.86, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.24, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.28, y: 0.46, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 30, title: "Nebula Thread", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.18, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.28, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.44, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.60, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.72, y: 0.14, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 5, x: 0.86, y: 0.30, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.82, y: 0.56, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.66, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.46, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.26, y: 0.72, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 31, title: "Shadow Star", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.86, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.86, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.70, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.50, y: 0.88, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.30, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.14, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.14, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.30, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.50, y: 0.50, size: 1.2, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 32, title: "Silent Crown", regionId: 4, difficulty: .hard,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.08, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.66, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.80, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.88, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.82, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.66, y: 0.78, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.86, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 7, x: 0.34, y: 0.78, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.18, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.12, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.20, y: 0.18, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                hasAtlasFragment: true
            )
        ]
    }

    // MARK: - Region 5: Crown of Night (Levels 33–40, Expert, 10–12 stars)

    private static func crownOfNight() -> [ConstellationLevel] {
        [
            ConstellationLevel(
                id: 33, title: "High Compass", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.08, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.62, y: 0.22, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.78, y: 0.20, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.86, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.82, y: 0.58, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.70, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.30, y: 0.72, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.18, y: 0.58, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.14, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.22, y: 0.20, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 34, title: "Royal Line", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.14, y: 0.30, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.28, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.44, y: 0.14, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.60, y: 0.24, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.76, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.88, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.82, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.66, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.50, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.30, y: 0.74, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.14, y: 0.58, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 35, title: "Last Meridian", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.68, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.82, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.86, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.74, y: 0.74, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.50, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.26, y: 0.74, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.14, y: 0.54, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.18, y: 0.34, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.32, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.50, y: 0.46, size: 1.2, isFragmentStar: true)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 36, title: "Crown Pattern", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.08, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.62, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.76, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.86, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.88, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.80, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.68, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.50, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.32, y: 0.76, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.20, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.12, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 11, x: 0.14, y: 0.28, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 37, title: "Night Seal", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.24, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.76, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.88, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.82, y: 0.64, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.62, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.88, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.38, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.18, y: 0.64, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.12, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.34, y: 0.46, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 11, x: 0.66, y: 0.46, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 38, title: "Final Orbit", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.08, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.66, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.80, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.90, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.86, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.70, y: 0.78, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.86, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 7, x: 0.30, y: 0.78, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.14, y: 0.60, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.10, y: 0.38, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.20, y: 0.18, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 11, x: 0.34, y: 0.18, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                hasAtlasFragment: true
            ),
            ConstellationLevel(
                id: 39, title: "Atlas Gate", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.10, size: 1.1, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.70, y: 0.14, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.86, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.92, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.84, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.66, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 6, x: 0.50, y: 0.88, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.34, y: 0.82, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.16, y: 0.70, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.08, y: 0.50, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.14, y: 0.28, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 11, x: 0.30, y: 0.14, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                hasAtlasFragment: false
            ),
            ConstellationLevel(
                id: 40, title: "Sky Restored", regionId: 5, difficulty: .expert,
                stars: [
                    StarPoint(id: 0, x: 0.50, y: 0.08, size: 1.2, isFragmentStar: false),
                    StarPoint(id: 1, x: 0.66, y: 0.16, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 2, x: 0.80, y: 0.22, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 3, x: 0.90, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 4, x: 0.88, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 5, x: 0.74, y: 0.80, size: 1.0, isFragmentStar: true),
                    StarPoint(id: 6, x: 0.50, y: 0.88, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 7, x: 0.26, y: 0.80, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 8, x: 0.12, y: 0.62, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 9, x: 0.10, y: 0.40, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 10, x: 0.20, y: 0.22, size: 1.0, isFragmentStar: false),
                    StarPoint(id: 11, x: 0.34, y: 0.16, size: 1.0, isFragmentStar: false)
                ],
                correctRoute: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                hasAtlasFragment: true
            )
        ]
    }
}
