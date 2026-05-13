import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var showResetConfirm = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()
                StarfieldBackgroundView(starCount: 40)

                ScrollView {
                    VStack(spacing: AppSpacing.lg) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Settings")
                                .font(.atlasTitle)
                                .foregroundColor(.starMist)
                            Text("Customize your experience")
                                .font(.atlasBody)
                                .foregroundColor(.starMist.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.top, AppSpacing.md)

                        // Preferences
                        GlassAtlasCardView {
                            VStack(spacing: 0) {
                                SettingsToggleRow(
                                    icon: "speaker.wave.2.fill",
                                    title: "Sound Effects",
                                    isOn: store.soundEnabled
                                ) {
                                    store.toggleSound()
                                }

                                Divider().background(Color.starMist.opacity(0.08))

                                SettingsToggleRow(
                                    icon: "iphone.radiowaves.left.and.right",
                                    title: "Haptic Feedback",
                                    isOn: store.hapticsEnabled
                                ) {
                                    store.toggleHaptics()
                                }

                                Divider().background(Color.starMist.opacity(0.08))

                                SettingsToggleRow(
                                    icon: "figure.walk",
                                    title: "Reduced Motion",
                                    isOn: store.reducedMotion
                                ) {
                                    store.toggleReducedMotion()
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Statistics summary
                        GlassAtlasCardView {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                HStack(spacing: AppSpacing.sm) {
                                    Image(systemName: "chart.bar.fill")
                                        .foregroundColor(.astralGold)
                                        .font(.system(size: 16))
                                    Text("Your Progress Summary")
                                        .font(.atlasSection)
                                        .foregroundColor(.starMist)
                                }

                                VStack(spacing: 6) {
                                    SummaryRow(label: "Constellations completed", value: "\(store.completedCount)/40")
                                    SummaryRow(label: "Total Sky Marks", value: "\(store.totalSkyMarks)")
                                    SummaryRow(label: "Atlas Fragments collected", value: "\(store.totalFragments)")
                                    SummaryRow(label: "Perfect routes", value: "\(store.totalPerfectRoutes)")
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)

                        // Reset section
                        GlassAtlasCardView {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                HStack(spacing: AppSpacing.sm) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.flareCoral)
                                        .font(.system(size: 16))
                                    Text("Danger Zone")
                                        .font(.atlasSection)
                                        .foregroundColor(.starMist)
                                }

                                Text("Resetting your progress will clear all completed levels, Sky Marks, Atlas Fragments, achievements, and return you to the beginning.")
                                    .font(.atlasBody)
                                    .foregroundColor(.starMist.opacity(0.55))
                                    .lineSpacing(3)

                                PrimaryActionButton(title: "Reset All Progress", action: {
                                    showResetConfirm = true
                                }, isDestructive: true)
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.bottom, AppSpacing.xl)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Reset All Progress?", isPresented: $showResetConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    store.resetAllProgress()
                }
            } message: {
                Text("All your constellations, Sky Marks, Atlas Fragments, and achievements will be cleared. This cannot be undone.")
            }
        }
    }
}

private struct SettingsToggleRow: View {
    let icon: String
    let title: String
    let isOn: Bool
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.astralGold.opacity(0.8))
                .frame(width: 24)
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.starMist)
            Spacer()
            Toggle("", isOn: Binding(
                get: { isOn },
                set: { _ in onToggle() }
            ))
            .toggleStyle(SwitchToggleStyle(tint: .astralGold))
            .labelsHidden()
        }
        .padding(.vertical, AppSpacing.sm)
        .accessibilityLabel(title)
    }
}

private struct SummaryRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.atlasBody)
                .foregroundColor(.starMist.opacity(0.6))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.astralGold)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AtlasProgressStore.shared)
}
