import SwiftUI

struct SkyRegionsView: View {
    @EnvironmentObject var store: AtlasProgressStore

    var body: some View {
        ZStack {
            Color.deepSpaceBackground.ignoresSafeArea()
            StarfieldBackgroundView(starCount: 60)

            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    ForEach(store.regions) { region in
                        RegionFullCard(region: region)
                            .padding(.horizontal, AppSpacing.lg)
                    }
                    Spacer(minLength: AppSpacing.xl)
                }
                .padding(.top, AppSpacing.sm)
            }
        }
        .navigationTitle("Sky Regions")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.deepSpaceBackground, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

private struct RegionFullCard: View {
    @EnvironmentObject var store: AtlasProgressStore
    let region: SkyRegion

    var isUnlocked: Bool { store.isLevelUnlocked(region.firstLevelId) }
    var completedCount: Int { store.regionProgress(for: region) }
    var skyMarks: Int { store.regionSkyMarks(for: region) }
    var hasBadge: Bool { store.hasBadge(for: region) }

    var body: some View {
        GlassAtlasCardView(padding: AppSpacing.lg) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack(spacing: AppSpacing.md) {
                    // Region icon
                    ZStack {
                        Circle()
                            .fill(isUnlocked ? regionColor.opacity(0.15) : Color.starMist.opacity(0.04))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Circle()
                                    .stroke(isUnlocked ? regionColor.opacity(0.4) : Color.starMist.opacity(0.1), lineWidth: 1.5)
                            )
                        Image(systemName: regionIcon)
                            .font(.system(size: 24))
                            .foregroundColor(isUnlocked ? regionColor : .starMist.opacity(0.2))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: AppSpacing.xs) {
                            Text(region.name)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(isUnlocked ? .starMist : .starMist.opacity(0.4))
                            if !isUnlocked {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(.starMist.opacity(0.3))
                            }
                        }
                        Text(region.difficulty.displayName)
                            .font(.atlasSmall)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Capsule().fill(difficultyColor.opacity(0.15)))
                            .foregroundColor(difficultyColor)
                    }

                    Spacer()

                    if hasBadge {
                        VStack(spacing: 4) {
                            Image(systemName: "seal.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.orbitGreen)
                            Text("Badge")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.orbitGreen.opacity(0.8))
                        }
                    }
                }

                // Mood description
                Text(region.mood)
                    .font(.atlasBody)
                    .foregroundColor(.starMist.opacity(0.5))
                    .lineLimit(2)

                Divider()
                    .background(Color.starMist.opacity(0.08))

                // Progress stats
                HStack(spacing: 0) {
                    RegionStatCell(value: "\(completedCount)/8", label: "Levels")
                    RegionStatCell(value: "\(skyMarks)", label: "Sky Marks", color: .astralGold)
                    RegionStatCell(
                        value: hasBadge ? "Earned" : "—",
                        label: "Region Badge",
                        color: hasBadge ? .orbitGreen : .starMist.opacity(0.4)
                    )
                }

                // Progress bar
                if isUnlocked {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(completedCount) of 8 constellations")
                            .font(.atlasCaption)
                            .foregroundColor(.starMist.opacity(0.4))
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.starMist.opacity(0.08))
                                    .frame(height: 6)
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(completedCount == 8 ? Color.orbitGreen : Color.astralGold)
                                    .frame(width: geo.size.width * CGFloat(completedCount) / 8.0, height: 6)
                                    .animation(.spring(response: 0.5), value: completedCount)
                            }
                        }
                        .frame(height: 6)
                    }
                } else {
                    Text("Complete the previous region to unlock")
                        .font(.atlasCaption)
                        .foregroundColor(.starMist.opacity(0.3))
                }
            }
        }
        .opacity(isUnlocked ? 1 : 0.65)
    }

    private var regionColor: Color {
        switch region.id {
        case 1: return .starMist.opacity(0.9)
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

private struct RegionStatCell: View {
    let value: String
    let label: String
    var color: Color = .starMist

    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(.atlasCaption)
                .foregroundColor(.starMist.opacity(0.45))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SkyRegionsView()
        .environmentObject(AtlasProgressStore.shared)
}
