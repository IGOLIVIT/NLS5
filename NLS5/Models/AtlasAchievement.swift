import Foundation

struct AtlasAchievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let iconName: String
    var isUnlocked: Bool

    static let all: [AtlasAchievement] = [
        AtlasAchievement(id: "first_spark", title: "First Spark", description: "Complete your first constellation.", iconName: "sparkle", isUnlocked: false),
        AtlasAchievement(id: "clean_line", title: "Clean Line", description: "Complete any level with no mistakes.", iconName: "line.diagonal", isUnlocked: false),
        AtlasAchievement(id: "no_hint_route", title: "No-Hint Route", description: "Complete any level without using hints.", iconName: "eye.slash", isUnlocked: false),
        AtlasAchievement(id: "quiet_horizon_badge", title: "Quiet Horizon Badge", description: "Complete all Quiet Horizon levels.", iconName: "seal.fill", isUnlocked: false),
        AtlasAchievement(id: "golden_meridian_badge", title: "Golden Meridian Badge", description: "Complete all Golden Meridian levels.", iconName: "seal.fill", isUnlocked: false),
        AtlasAchievement(id: "emerald_orbit_badge", title: "Emerald Orbit Badge", description: "Complete all Emerald Orbit levels.", iconName: "seal.fill", isUnlocked: false),
        AtlasAchievement(id: "silent_nebula_badge", title: "Silent Nebula Badge", description: "Complete all Silent Nebula levels.", iconName: "seal.fill", isUnlocked: false),
        AtlasAchievement(id: "crown_of_night_badge", title: "Crown of Night Badge", description: "Complete all Crown of Night levels.", iconName: "crown.fill", isUnlocked: false),
        AtlasAchievement(id: "fragment_seeker", title: "Fragment Seeker", description: "Collect 10 Atlas Fragments.", iconName: "doc.text.magnifyingglass", isUnlocked: false),
        AtlasAchievement(id: "perfect_constellation", title: "Perfect Constellation", description: "Earn 3 Sky Marks on any level.", iconName: "star.fill", isUnlocked: false),
        AtlasAchievement(id: "atlas_keeper", title: "Atlas Keeper", description: "Complete 20 constellations.", iconName: "book.closed.fill", isUnlocked: false),
        AtlasAchievement(id: "sky_restored", title: "Sky Restored", description: "Complete all 40 constellations.", iconName: "moon.stars.fill", isUnlocked: false)
    ]
}
