import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var currentPage = 0
    @State private var opacity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Restore the night",
            text: "Reconnect faded stars and bring ancient constellations back to the sky.",
            symbol: "sparkles"
        ),
        OnboardingPage(
            title: "Follow the hidden line",
            text: "Choose the right stars, draw glowing paths, and complete each celestial route.",
            symbol: "arrow.triangle.branch"
        ),
        OnboardingPage(
            title: "Open the atlas",
            text: "Unlock sky regions, collect atlas fragments, and master every constellation.",
            symbol: "map.fill"
        )
    ]

    var body: some View {
        ZStack {
            StarfieldBackgroundView(starCount: 100)

            VStack(spacing: 0) {
                Spacer()

                // Atlas Lens
                AtlasLensView(size: 130)
                    .padding(.bottom, AppSpacing.xl)

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 220)
                .animation(reduceMotion ? nil : .easeInOut(duration: 0.4), value: currentPage)

                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { i in
                        Capsule()
                            .fill(i == currentPage ? Color.astralGold : Color.starMist.opacity(0.25))
                            .frame(width: i == currentPage ? 24 : 6, height: 6)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentPage)
                    }
                }
                .padding(.top, AppSpacing.lg)

                Spacer()

                // Action buttons
                VStack(spacing: AppSpacing.sm) {
                    if currentPage < pages.count - 1 {
                        PrimaryActionButton(title: "Continue") {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    } else {
                        PrimaryActionButton(title: "Begin the Map") {
                            store.completeOnboarding()
                        }
                    }

                    if currentPage > 0 {
                        SecondaryActionButton(title: "Back") {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(reduceMotion ? nil : .easeIn(duration: 0.6)) {
                opacity = 1
            }
        }
    }
}

private struct OnboardingPage {
    let title: String
    let text: String
    let symbol: String
}

private struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: page.symbol)
                .font(.system(size: 36, weight: .light))
                .foregroundColor(.astralGold)
                .frame(height: 48)

            Text(page.title)
                .font(.atlasTitle)
                .foregroundColor(.starMist)
                .multilineTextAlignment(.center)

            Text(page.text)
                .font(.atlasBody)
                .foregroundColor(.starMist.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, AppSpacing.xl)
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AtlasProgressStore.shared)
}
