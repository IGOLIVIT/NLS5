import Foundation
import Combine

final class AtlasProgressStore: ObservableObject {

    static let shared = AtlasProgressStore()

    // MARK: - Persistence Keys
    private enum Keys {
        static let onboardingDone = "atlas_onboarding_done"
        static let levelResults = "atlas_level_results"
        static let totalSkyMarks = "atlas_total_sky_marks"
        static let totalFragments = "atlas_total_fragments"
        static let totalPerfectRoutes = "atlas_perfect_routes"
        static let totalMistakes = "atlas_total_mistakes"
        static let totalHints = "atlas_total_hints"
        static let achievementIds = "atlas_achievement_ids"
        static let soundEnabled = "atlas_sound_enabled"
        static let hapticsEnabled = "atlas_haptics_enabled"
        static let reducedMotion = "atlas_reduced_motion"
        static let dailyCompletion = "atlas_daily_completion"
    }

    // MARK: - Published State
    @Published var onboardingCompleted: Bool = false
    @Published var levelResults: [Int: LevelResult] = [:]
    @Published var totalSkyMarks: Int = 0
    @Published var totalFragments: Int = 0
    @Published var totalPerfectRoutes: Int = 0
    @Published var totalMistakes: Int = 0
    @Published var totalHints: Int = 0
    @Published var unlockedAchievementIds: Set<String> = []
    @Published var soundEnabled: Bool = true
    @Published var hapticsEnabled: Bool = true
    @Published var reducedMotion: Bool = false
    @Published var dailyCompletionDates: Set<String> = []

    let levels: [ConstellationLevel]
    let regions: [SkyRegion]

    private init() {
        levels = ConstellationLevelFactory.makeAllLevels()
        regions = SkyRegion.all
        loadAll()
    }

    // MARK: - Computed Properties

    var completedLevelIds: Set<Int> {
        Set(levelResults.keys)
    }

    var completedCount: Int {
        completedLevelIds.count
    }

    var currentRegion: SkyRegion {
        let nextUnlocked = nextUnlockedLevel
        return SkyRegion.region(for: nextUnlocked?.id ?? 1) ?? regions[0]
    }

    var nextUnlockedLevel: ConstellationLevel? {
        levels.first { !completedLevelIds.contains($0.id) && isLevelUnlocked($0.id) }
    }

    var bestMistakeFreeStreak: Int {
        var streak = 0
        var best = 0
        for level in levels.sorted(by: { $0.id < $1.id }) {
            if let result = levelResults[level.id], result.bestMistakes == 0 {
                streak += 1
                best = max(best, streak)
            } else {
                streak = 0
            }
        }
        return best
    }

    var completedRegions: [SkyRegion] {
        regions.filter { region in
            region.levelIds.allSatisfy { completedLevelIds.contains($0) }
        }
    }

    var achievements: [AtlasAchievement] {
        AtlasAchievement.all.map { ach in
            var copy = ach
            copy.isUnlocked = unlockedAchievementIds.contains(ach.id)
            return copy
        }
    }

    func isLevelUnlocked(_ levelId: Int) -> Bool {
        if levelId == 1 { return true }
        return completedLevelIds.contains(levelId - 1)
    }

    func skyMarks(for levelId: Int) -> Int {
        levelResults[levelId]?.bestSkyMarks ?? 0
    }

    func regionProgress(for region: SkyRegion) -> Int {
        region.levelIds.filter { completedLevelIds.contains($0) }.count
    }

    func regionSkyMarks(for region: SkyRegion) -> Int {
        region.levelIds.compactMap { levelResults[$0]?.bestSkyMarks }.reduce(0, +)
    }

    func hasBadge(for region: SkyRegion) -> Bool {
        region.levelIds.allSatisfy { completedLevelIds.contains($0) }
    }

    // MARK: - Daily Constellation

    var todayDateKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    var dailyLevel: ConstellationLevel? {
        let unlockedLevels = levels.filter { isLevelUnlocked($0.id) }
        guard !unlockedLevels.isEmpty else { return levels.first }
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = (dayOfYear - 1) % unlockedLevels.count
        return unlockedLevels[index]
    }

    var dailyCompleted: Bool {
        dailyCompletionDates.contains(todayDateKey)
    }

    func completeDailyConstellation() {
        dailyCompletionDates.insert(todayDateKey)
        saveDailyCompletion()
    }

    // MARK: - Level Completion

    func recordLevelCompletion(levelId: Int, mistakes: Int, hints: Int, fragmentCollected: Bool) {
        let skyMarks = calculateSkyMarks(mistakes: mistakes, hints: hints)
        let isPerfect = mistakes == 0 && hints == 0

        let existing = levelResults[levelId]
        let previousBestMarks = existing?.bestSkyMarks ?? 0
        let newBestMarks = max(previousBestMarks, skyMarks)

        let newResult = LevelResult(
            bestSkyMarks: newBestMarks,
            bestMistakes: existing == nil ? mistakes : min(existing!.bestMistakes, mistakes),
            bestHints: existing == nil ? hints : min(existing!.bestHints, hints),
            fragmentCollected: (existing?.fragmentCollected ?? false) || fragmentCollected,
            isPerfect: (existing?.isPerfect ?? false) || isPerfect
        )

        levelResults[levelId] = newResult

        // Only count the improvement to totalSkyMarks, not a full re-add on replay
        totalSkyMarks += (newBestMarks - previousBestMarks)

        // Count fragment only the first time it's collected on this level
        let isFirstFragment = fragmentCollected && !(existing?.fragmentCollected ?? false)
        if isFirstFragment { totalFragments += 1 }

        // Count perfect route only the first time
        let isFirstPerfect = isPerfect && !(existing?.isPerfect ?? false)
        if isFirstPerfect { totalPerfectRoutes += 1 }

        saveLevelResults()
        saveTotals()
        checkAndUnlockAchievements(levelId: levelId)
    }

    private func calculateSkyMarks(mistakes: Int, hints: Int) -> Int {
        if mistakes == 0 && hints == 0 { return 3 }
        if mistakes <= 2 || hints <= 1 { return 2 }
        return 1
    }

    // MARK: - Achievements

    private func checkAndUnlockAchievements(levelId: Int) {
        var newUnlocks: [String] = []

        if levelId == 1 { newUnlocks.append("first_spark") }
        if let result = levelResults[levelId] {
            if result.bestMistakes == 0 { newUnlocks.append("clean_line") }
            if result.bestHints == 0 { newUnlocks.append("no_hint_route") }
            if result.bestSkyMarks == 3 { newUnlocks.append("perfect_constellation") }
        }
        if SkyRegion.all[0].levelIds.allSatisfy({ completedLevelIds.contains($0) }) {
            newUnlocks.append("quiet_horizon_badge")
        }
        if SkyRegion.all[1].levelIds.allSatisfy({ completedLevelIds.contains($0) }) {
            newUnlocks.append("golden_meridian_badge")
        }
        if SkyRegion.all[2].levelIds.allSatisfy({ completedLevelIds.contains($0) }) {
            newUnlocks.append("emerald_orbit_badge")
        }
        if SkyRegion.all[3].levelIds.allSatisfy({ completedLevelIds.contains($0) }) {
            newUnlocks.append("silent_nebula_badge")
        }
        if SkyRegion.all[4].levelIds.allSatisfy({ completedLevelIds.contains($0) }) {
            newUnlocks.append("crown_of_night_badge")
        }
        if totalFragments >= 10 { newUnlocks.append("fragment_seeker") }
        if completedCount >= 20 { newUnlocks.append("atlas_keeper") }
        if completedCount >= 40 { newUnlocks.append("sky_restored") }

        for id in newUnlocks {
            unlockedAchievementIds.insert(id)
        }
        saveAchievements()
    }

    // MARK: - Settings

    func toggleSound() { soundEnabled.toggle(); saveSettings() }
    func toggleHaptics() { hapticsEnabled.toggle(); saveSettings() }
    func toggleReducedMotion() { reducedMotion.toggle(); saveSettings() }

    // MARK: - Reset

    func resetAllProgress() {
        onboardingCompleted = false
        levelResults = [:]
        totalSkyMarks = 0
        totalFragments = 0
        totalPerfectRoutes = 0
        totalMistakes = 0
        totalHints = 0
        unlockedAchievementIds = []
        dailyCompletionDates = []
        UserDefaults.standard.removeObject(forKey: Keys.onboardingDone)
        UserDefaults.standard.removeObject(forKey: Keys.levelResults)
        UserDefaults.standard.removeObject(forKey: Keys.totalSkyMarks)
        UserDefaults.standard.removeObject(forKey: Keys.totalFragments)
        UserDefaults.standard.removeObject(forKey: Keys.totalPerfectRoutes)
        UserDefaults.standard.removeObject(forKey: Keys.totalMistakes)
        UserDefaults.standard.removeObject(forKey: Keys.totalHints)
        UserDefaults.standard.removeObject(forKey: Keys.achievementIds)
        UserDefaults.standard.removeObject(forKey: Keys.dailyCompletion)
    }

    func completeOnboarding() {
        onboardingCompleted = true
        UserDefaults.standard.set(true, forKey: Keys.onboardingDone)
    }

    // MARK: - Persistence

    private func loadAll() {
        onboardingCompleted = UserDefaults.standard.bool(forKey: Keys.onboardingDone)
        soundEnabled = UserDefaults.standard.object(forKey: Keys.soundEnabled) as? Bool ?? true
        hapticsEnabled = UserDefaults.standard.object(forKey: Keys.hapticsEnabled) as? Bool ?? true
        reducedMotion = UserDefaults.standard.bool(forKey: Keys.reducedMotion)
        totalSkyMarks = UserDefaults.standard.integer(forKey: Keys.totalSkyMarks)
        totalFragments = UserDefaults.standard.integer(forKey: Keys.totalFragments)
        totalPerfectRoutes = UserDefaults.standard.integer(forKey: Keys.totalPerfectRoutes)
        totalMistakes = UserDefaults.standard.integer(forKey: Keys.totalMistakes)
        totalHints = UserDefaults.standard.integer(forKey: Keys.totalHints)

        if let data = UserDefaults.standard.data(forKey: Keys.levelResults),
           let decoded = try? JSONDecoder().decode([Int: LevelResult].self, from: data) {
            levelResults = decoded
        }
        if let ids = UserDefaults.standard.array(forKey: Keys.achievementIds) as? [String] {
            unlockedAchievementIds = Set(ids)
        }
        if let dates = UserDefaults.standard.array(forKey: Keys.dailyCompletion) as? [String] {
            dailyCompletionDates = Set(dates)
        }
    }

    private func saveLevelResults() {
        if let data = try? JSONEncoder().encode(levelResults) {
            UserDefaults.standard.set(data, forKey: Keys.levelResults)
        }
    }

    private func saveTotals() {
        UserDefaults.standard.set(totalSkyMarks, forKey: Keys.totalSkyMarks)
        UserDefaults.standard.set(totalFragments, forKey: Keys.totalFragments)
        UserDefaults.standard.set(totalPerfectRoutes, forKey: Keys.totalPerfectRoutes)
        UserDefaults.standard.set(totalMistakes, forKey: Keys.totalMistakes)
        UserDefaults.standard.set(totalHints, forKey: Keys.totalHints)
    }

    private func saveAchievements() {
        UserDefaults.standard.set(Array(unlockedAchievementIds), forKey: Keys.achievementIds)
    }

    private func saveSettings() {
        UserDefaults.standard.set(soundEnabled, forKey: Keys.soundEnabled)
        UserDefaults.standard.set(hapticsEnabled, forKey: Keys.hapticsEnabled)
        UserDefaults.standard.set(reducedMotion, forKey: Keys.reducedMotion)
    }

    private func saveDailyCompletion() {
        UserDefaults.standard.set(Array(dailyCompletionDates), forKey: Keys.dailyCompletion)
    }
}
