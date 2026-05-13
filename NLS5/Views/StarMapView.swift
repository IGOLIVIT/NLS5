import SwiftUI

struct StarMapView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var selectedLevel: ConstellationLevel? = nil
    @State private var selectedRegionId: Int = 1

    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()
                StarfieldBackgroundView(starCount: 50)

                VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Star Map")
                                .font(.atlasTitle)
                                .foregroundColor(.starMist)
                            Text("\(store.completedCount) of 40 constellations restored")
                                .font(.atlasSmall)
                                .foregroundColor(.starMist.opacity(0.5))
                        }
                        Spacer()
                        ProgressRingView(
                            progress: Double(store.completedCount) / 40.0,
                            total: 40,
                            completed: store.completedCount,
                            size: 56
                        )
                    }
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)
                    .padding(.bottom, AppSpacing.sm)

                    // Region selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AppSpacing.sm) {
                            ForEach(store.regions) { region in
                                RegionTabButton(
                                    region: region,
                                    isSelected: selectedRegionId == region.id,
                                    isUnlocked: store.isLevelUnlocked(region.firstLevelId)
                                ) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedRegionId = region.id
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)
                    }
                    .padding(.bottom, AppSpacing.sm)

                    Divider()
                        .background(Color.starMist.opacity(0.08))

                    // Level list
                    if let region = store.regions.first(where: { $0.id == selectedRegionId }) {
                        ScrollView {
                            LazyVStack(spacing: AppSpacing.sm) {
                                // Region header card
                                RegionHeaderCard(region: region)
                                    .padding(.top, AppSpacing.sm)

                                ForEach(region.levelIds, id: \.self) { levelId in
                                    if let level = store.levels.first(where: { $0.id == levelId }) {
                                        LevelCardView(
                                            level: level,
                                            result: store.levelResults[levelId],
                                            isUnlocked: store.isLevelUnlocked(levelId)
                                        ) {
                                            selectedLevel = level
                                        }
                                    }
                                }
                                .padding(.bottom, AppSpacing.md)
                            }
                            .padding(.horizontal, AppSpacing.lg)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedLevel) { level in
                ConstellationGameView(level: level)
            }
        }
    }
}

private struct RegionTabButton: View {
    let region: SkyRegion
    let isSelected: Bool
    let isUnlocked: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 3) {
                Text(region.name)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(
                        isSelected ? .astralGold :
                        isUnlocked ? .starMist.opacity(0.7) :
                        .starMist.opacity(0.25)
                    )
                if isSelected {
                    Capsule()
                        .fill(Color.astralGold)
                        .frame(height: 2)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 2)
                }
            }
            .padding(.horizontal, AppSpacing.sm)
            .padding(.vertical, AppSpacing.xs)
        }
        .buttonStyle(.plain)
        .disabled(!isUnlocked)
    }
}

private struct RegionHeaderCard: View {
    @EnvironmentObject var store: AtlasProgressStore
    let region: SkyRegion

    var completedCount: Int { store.regionProgress(for: region) }
    var skyMarks: Int { store.regionSkyMarks(for: region) }
    var hasBadge: Bool { store.hasBadge(for: region) }
    var isUnlocked: Bool { store.isLevelUnlocked(region.firstLevelId) }

    var body: some View {
        GlassAtlasCardView {
            HStack(spacing: AppSpacing.md) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(region.name)
                        .font(.atlasSection)
                        .foregroundColor(isUnlocked ? .starMist : .starMist.opacity(0.4))
                    Text(region.mood)
                        .font(.atlasSmall)
                        .foregroundColor(.starMist.opacity(0.5))
                        .lineLimit(2)
                    HStack(spacing: AppSpacing.sm) {
                        Text(region.difficulty.displayName)
                            .font(.atlasCaption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Capsule().fill(difficultyColor.opacity(0.15)))
                            .foregroundColor(difficultyColor)
                        Text("\(completedCount)/8 levels")
                            .font(.atlasCaption)
                            .foregroundColor(.starMist.opacity(0.5))
                    }
                }
                Spacer()
                VStack(spacing: 6) {
                    if hasBadge {
                        Image(systemName: "seal.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.orbitGreen)
                    } else {
                        ZStack {
                            Circle()
                                .stroke(Color.starMist.opacity(0.1), lineWidth: 2)
                                .frame(width: 44, height: 44)
                            Circle()
                                .trim(from: 0, to: CGFloat(completedCount) / 8.0)
                                .stroke(Color.astralGold, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                                .frame(width: 44, height: 44)
                                .rotationEffect(.degrees(-90))
                        }
                    }
                    Text("\(skyMarks) marks")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.astralGold.opacity(0.7))
                }
            }
        }
    }

    private var difficultyColor: Color {
        switch region.difficulty {
        case .beginner: return .orbitGreen
        case .easy: return .astralGold
        case .medium: return Color(red: 0.9, green: 0.7, blue: 0.3)
        case .hard: return Color.flareCoral.opacity(0.9)
        case .expert: return Color.flareCoral
        }
    }
}

#Preview {
    StarMapView()
        .environmentObject(AtlasProgressStore.shared)
}
