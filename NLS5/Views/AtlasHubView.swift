import SwiftUI

struct AtlasHubView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var navigateToGame: ConstellationLevel? = nil
    @State private var showHowToPlay = false
    @State private var showAchievements = false

    var body: some View {
        NavigationStack {
            ZStack {
                NebulaBackgroundView()

                ScrollView {
                    VStack(spacing: AppSpacing.lg) {

                        // Header with Atlas Lens
                        VStack(spacing: AppSpacing.md) {
                            AtlasLensView(size: 100)
                                .padding(.top, AppSpacing.lg)

                            VStack(spacing: 4) {
                                Text(store.currentRegion.name)
                                    .font(.atlasSection)
                                    .foregroundColor(.astralGold)
                                Text(store.currentRegion.difficulty.displayName)
                                    .font(.atlasCaption)
                                    .foregroundColor(.starMist.opacity(0.5))
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Stats row
                        HStack(spacing: AppSpacing.sm) {
                            StatTileView(value: "\(store.totalSkyMarks)", label: "Sky Marks")
                            StatTileView(value: "\(store.completedCount)", label: "Completed", color: .orbitGreen)
                            StatTileView(value: "\(store.totalFragments)", label: "Fragments", color: .starMist.opacity(0.8))
                            StatTileView(value: "\(store.totalPerfectRoutes)", label: "Perfect", color: .astralGold)
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Daily constellation card
                        if let daily = store.dailyLevel {
                            DailyConstellationCard(level: daily, completed: store.dailyCompleted) {
                                navigateToGame = daily
                            }
                            .padding(.horizontal, AppSpacing.lg)
                        }

                        // Current recommended level
                        if let next = store.nextUnlockedLevel {
                            GlassAtlasCardView {
                                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text("Next Constellation")
                                                .font(.atlasCaption)
                                                .foregroundColor(.starMist.opacity(0.5))
                                            Text(next.title)
                                                .font(.atlasSection)
                                                .foregroundColor(.starMist)
                                            Text("\(next.difficulty.displayName) · \(SkyRegion.region(for: next.id)?.name ?? "")")
                                                .font(.atlasSmall)
                                                .foregroundColor(.starMist.opacity(0.6))
                                        }
                                        Spacer()
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 28))
                                            .foregroundColor(.astralGold.opacity(0.4))
                                    }
                                    .padding(.bottom, 4)
                                    PrimaryActionButton(title: "Continue Map") {
                                        navigateToGame = next
                                    }
                                }
                            }
                            .padding(.horizontal, AppSpacing.lg)
                        } else {
                            GlassAtlasCardView {
                                VStack(spacing: AppSpacing.sm) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(.orbitGreen)
                                    Text("All constellations restored!")
                                        .font(.atlasSection)
                                        .foregroundColor(.starMist)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, AppSpacing.sm)
                            }
                            .padding(.horizontal, AppSpacing.lg)
                        }

                        // Action buttons
                        VStack(spacing: AppSpacing.sm) {
                            SecondaryActionButton(title: "How to Play") {
                                showHowToPlay = true
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Region progress
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("Sky Regions")
                                .font(.atlasSection)
                                .foregroundColor(.starMist)
                                .padding(.horizontal, AppSpacing.lg)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppSpacing.md) {
                                    ForEach(store.regions) { region in
                                        RegionMiniCard(region: region)
                                    }
                                }
                                .padding(.horizontal, AppSpacing.lg)
                            }
                        }

                        // Achievement preview
                        AchievementPreviewCard {
                            showAchievements = true
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.bottom, AppSpacing.xl)
                    }
                }
            }
            .navigationDestination(item: $navigateToGame) { level in
                ConstellationGameView(level: level)
            }
            .sheet(isPresented: $showHowToPlay) {
                HowToPlayView()
                    .environmentObject(store)
            }
            .sheet(isPresented: $showAchievements) {
                AchievementsView()
                    .environmentObject(store)
            }
            .navigationBarHidden(true)
        }
    }
}

private struct DailyConstellationCard: View {
    let level: ConstellationLevel
    let completed: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            GlassAtlasCardView {
                HStack(spacing: AppSpacing.md) {
                    ZStack {
                        Circle()
                            .fill(completed ? Color.orbitGreen.opacity(0.2) : Color.astralGold.opacity(0.12))
                            .frame(width: 48, height: 48)
                        Image(systemName: completed ? "checkmark.circle.fill" : "moon.stars.fill")
                            .font(.system(size: 22))
                            .foregroundColor(completed ? .orbitGreen : .astralGold)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Daily Constellation")
                            .font(.atlasCaption)
                            .foregroundColor(.starMist.opacity(0.5))
                        Text(level.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.starMist)
                        Text(completed ? "Completed today" : "Tap to begin")
                            .font(.atlasCaption)
                            .foregroundColor(completed ? .orbitGreen.opacity(0.8) : .astralGold.opacity(0.7))
                    }

                    Spacer()

                    if !completed {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.starMist.opacity(0.4))
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(completed)
    }
}

private struct RegionMiniCard: View {
    @EnvironmentObject var store: AtlasProgressStore
    let region: SkyRegion

    var isUnlocked: Bool {
        store.isLevelUnlocked(region.firstLevelId)
    }
    var completed: Int {
        store.regionProgress(for: region)
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? regionColor.opacity(0.15) : Color.starMist.opacity(0.04))
                    .frame(width: 56, height: 56)
                    .overlay(
                        Circle()
                            .stroke(isUnlocked ? regionColor.opacity(0.4) : Color.starMist.opacity(0.1), lineWidth: 1.5)
                    )
                Image(systemName: regionIcon)
                    .font(.system(size: 22))
                    .foregroundColor(isUnlocked ? regionColor : .starMist.opacity(0.25))
            }
            Text(region.name)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.starMist.opacity(0.7))
                .multilineTextAlignment(.center)
                .frame(width: 70)
                .lineLimit(2)
            Text("\(completed)/8")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(completed == 8 ? .orbitGreen : .starMist.opacity(0.4))
        }
        .frame(width: 80)
    }

    private var regionColor: Color {
        switch region.id {
        case 1: return .starMist
        case 2: return .astralGold
        case 3: return .orbitGreen
        case 4: return Color(red: 0.5, green: 0.5, blue: 0.9)
        case 5: return Color.flareCoral.opacity(0.9)
        default: return .astralGold
        }
    }

    private var regionIcon: String {
        switch region.id {
        case 1: return "sun.horizon.fill"
        case 2: return "circle.hexagonpath.fill"
        case 3: return "circle.dashed"
        case 4: return "cloud.fill"
        case 5: return "crown.fill"
        default: return "star.fill"
        }
    }
}

private struct AchievementPreviewCard: View {
    @EnvironmentObject var store: AtlasProgressStore
    var onTap: () -> Void

    var unlocked: Int {
        store.achievements.filter { $0.isUnlocked }.count
    }

    var body: some View {
        Button(action: onTap) {
            GlassAtlasCardView {
                HStack {
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.astralGold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Achievements")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.starMist)
                        Text("\(unlocked) of \(store.achievements.count) unlocked")
                            .font(.atlasCaption)
                            .foregroundColor(.starMist.opacity(0.5))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.starMist.opacity(0.4))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AtlasHubView()
        .environmentObject(AtlasProgressStore.shared)
}
