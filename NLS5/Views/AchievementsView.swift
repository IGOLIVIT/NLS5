import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @Environment(\.dismiss) private var dismiss

    var achievements: [AtlasAchievement] { store.achievements }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()
                StarfieldBackgroundView(starCount: 40)

                ScrollView {
                    VStack(spacing: AppSpacing.md) {
                        // Summary
                        let unlocked = achievements.filter { $0.isUnlocked }.count
                        GlassAtlasCardView {
                            HStack(spacing: AppSpacing.md) {
                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.astralGold)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(unlocked) of \(achievements.count) Unlocked")
                                        .font(.atlasSection)
                                        .foregroundColor(.starMist)
                                    ProgressView(value: Double(unlocked), total: Double(achievements.count))
                                        .tint(.astralGold)
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Achievement list
                        ForEach(achievements) { achievement in
                            AchievementRow(achievement: achievement)
                                .padding(.horizontal, AppSpacing.lg)
                        }

                        Spacer(minLength: AppSpacing.xl)
                    }
                    .padding(.top, AppSpacing.md)
                }
            }
            .navigationTitle("Achievements")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.deepSpaceBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(.astralGold)
                }
            }
        }
    }
}

private struct AchievementRow: View {
    let achievement: AtlasAchievement

    var body: some View {
        GlassAtlasCardView {
            HStack(spacing: AppSpacing.md) {
                ZStack {
                    Circle()
                        .fill(achievement.isUnlocked ? Color.astralGold.opacity(0.15) : Color.starMist.opacity(0.05))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Circle()
                                .stroke(
                                    achievement.isUnlocked ? Color.astralGold.opacity(0.4) : Color.starMist.opacity(0.1),
                                    lineWidth: 1.5
                                )
                        )
                    Image(systemName: achievement.isUnlocked ? achievement.iconName : "lock.fill")
                        .font(.system(size: achievement.isUnlocked ? 20 : 16))
                        .foregroundColor(achievement.isUnlocked ? .astralGold : .starMist.opacity(0.25))
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(achievement.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(achievement.isUnlocked ? .starMist : .starMist.opacity(0.4))
                    Text(achievement.description)
                        .font(.atlasCaption)
                        .foregroundColor(.starMist.opacity(achievement.isUnlocked ? 0.6 : 0.3))
                        .lineLimit(2)
                }

                Spacer()

                if achievement.isUnlocked {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.orbitGreen)
                }
            }
        }
    }
}

#Preview {
    AchievementsView()
        .environmentObject(AtlasProgressStore.shared)
}
