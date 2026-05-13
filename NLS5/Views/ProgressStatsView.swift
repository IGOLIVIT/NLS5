import SwiftUI

struct ProgressStatsView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var showAchievements = false
    @State private var showRegions = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()
                StarfieldBackgroundView(starCount: 50)

                ScrollView {
                    VStack(spacing: AppSpacing.lg) {
                        // Header
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Progress")
                                    .font(.atlasTitle)
                                    .foregroundColor(.starMist)
                                Text("Your celestial journey")
                                    .font(.atlasBody)
                                    .foregroundColor(.starMist.opacity(0.5))
                            }
                            Spacer()
                            ProgressRingView(
                                progress: Double(store.completedCount) / 40.0,
                                total: 40,
                                completed: store.completedCount,
                                ringColor: .orbitGreen,
                                size: 72
                            )
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.top, AppSpacing.md)

                        // Main stats grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppSpacing.sm) {
                            StatTileView(value: "\(store.completedCount)", label: "Completed")
                            StatTileView(value: "\(store.totalSkyMarks)", label: "Sky Marks", color: .astralGold)
                            StatTileView(value: "\(store.totalFragments)", label: "Atlas Fragments", color: .orbitGreen)
                            StatTileView(value: "\(store.totalPerfectRoutes)", label: "Perfect Routes", color: .astralGold)
                            StatTileView(value: "\(store.bestMistakeFreeStreak)", label: "Best Streak", color: .orbitGreen)
                            StatTileView(value: "\(store.completedRegions.count)/5", label: "Regions Done", color: .starMist.opacity(0.8))
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Current region
                        GlassAtlasCardView {
                            HStack(spacing: AppSpacing.md) {
                                Image(systemName: "location.north.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.astralGold)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Current Region")
                                        .font(.atlasCaption)
                                        .foregroundColor(.starMist.opacity(0.5))
                                    Text(store.currentRegion.name)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.starMist)
                                    Text(store.currentRegion.difficulty.displayName)
                                        .font(.atlasCaption)
                                        .foregroundColor(.astralGold.opacity(0.7))
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 3) {
                                    Text("\(store.regionProgress(for: store.currentRegion))/8")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.astralGold)
                                    Text("levels")
                                        .font(.atlasCaption)
                                        .foregroundColor(.starMist.opacity(0.4))
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Completed regions badges
                        if !store.completedRegions.isEmpty {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                Text("Earned Badges")
                                    .font(.atlasSection)
                                    .foregroundColor(.starMist)
                                    .padding(.horizontal, AppSpacing.lg)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: AppSpacing.md) {
                                        ForEach(store.completedRegions) { region in
                                            RegionBadgeView(region: region, isCompleted: true, isUnlocked: true)
                                                .frame(width: 72)
                                        }
                                    }
                                    .padding(.horizontal, AppSpacing.lg)
                                }
                            }
                        }

                        // Sky Regions shortcut
                        NavigationLink(destination: SkyRegionsView().environmentObject(store)) {
                            GlassAtlasCardView {
                                HStack(spacing: AppSpacing.md) {
                                    Image(systemName: "map.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.orbitGreen)
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Sky Regions")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.starMist)
                                        Text("\(store.completedRegions.count) of 5 regions complete")
                                            .font(.atlasCaption)
                                            .foregroundColor(.starMist.opacity(0.5))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.starMist.opacity(0.4))
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, AppSpacing.lg)

                        // Achievements shortcut
                        Button {
                            showAchievements = true
                        } label: {
                            GlassAtlasCardView {
                                HStack(spacing: AppSpacing.md) {
                                    Image(systemName: "trophy.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.astralGold)
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Achievements")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.starMist)
                                        let unlocked = store.achievements.filter { $0.isUnlocked }.count
                                        Text("\(unlocked) of \(store.achievements.count) unlocked")
                                            .font(.atlasCaption)
                                            .foregroundColor(.starMist.opacity(0.5))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.starMist.opacity(0.4))
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.bottom, AppSpacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showAchievements) {
                AchievementsView()
                    .environmentObject(store)
            }
        }
    }
}

#Preview {
    ProgressStatsView()
        .environmentObject(AtlasProgressStore.shared)
}
