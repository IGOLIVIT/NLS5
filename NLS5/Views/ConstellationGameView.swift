import SwiftUI

struct ConstellationGameView: View {
    let level: ConstellationLevel
    @StateObject private var engine: ConstellationGameEngine
    @EnvironmentObject var store: AtlasProgressStore
    @Environment(\.dismiss) private var dismiss

    @State private var showCompletion = false
    @State private var showPause = false
    @State private var wrongTapMessage = false
    @State private var nextLevelToPlay: ConstellationLevel? = nil

    init(level: ConstellationLevel) {
        self.level = level
        _engine = StateObject(wrappedValue: ConstellationGameEngine(level: level))
    }

    var body: some View {
        ZStack {
            Color.deepSpaceBackground.ignoresSafeArea()
            StarfieldBackgroundView(starCount: 40)

            VStack(spacing: 0) {
                // Top bar
                gameTopBar
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.top, AppSpacing.sm)

                // Game area
                GeometryReader { geo in
                    ZStack {
                        // Constellation lines (completed)
                        ForEach(engine.completedConnections) { connection in
                            if let fromStar = level.stars.first(where: { $0.id == connection.fromStarId }),
                               let toStar = level.stars.first(where: { $0.id == connection.toStarId }) {
                                ConstellationLineView(
                                    from: starPosition(fromStar, in: geo),
                                    to: starPosition(toStar, in: geo),
                                    color: .astralGold
                                )
                            }
                        }

                        // Stars
                        ForEach(level.stars) { star in
                            let nodeState = starState(star)
                            StarNodeView(star: star, state: nodeState) {
                                engine.tapStar(star.id)
                            }
                            .position(starPosition(star, in: geo))
                        }

                        // Wrong tap warning text
                        if wrongTapMessage {
                            Text("This star is not on the current line")
                                .font(.atlasSmall)
                                .foregroundColor(.flareCoral)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.flareCoral.opacity(0.15))
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.flareCoral.opacity(0.3), lineWidth: 1))
                                )
                                .transition(.opacity.combined(with: .scale))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .padding(AppSpacing.sm)

                // Bottom controls
                gameControls
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.bottom, AppSpacing.md)
            }

            // Pause overlay
            if showPause {
                pauseOverlay
            }

            // Completion overlay
            if showCompletion {
                completionOverlay
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(item: $nextLevelToPlay) { nextLevel in
            ConstellationGameView(level: nextLevel)
                .environmentObject(store)
        }
        .onChange(of: engine.gameState) { _, newState in
            if newState == .wrongTapWarning {
                withAnimation {
                    wrongTapMessage = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        wrongTapMessage = false
                    }
                }
            }
            if newState == .completed {
                let isDailyLevel = store.dailyLevel?.id == level.id
                store.recordLevelCompletion(
                    levelId: level.id,
                    mistakes: engine.mistakes,
                    hints: engine.hintsUsed,
                    fragmentCollected: engine.fragmentCollected
                )
                if isDailyLevel {
                    store.completeDailyConstellation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        showCompletion = true
                    }
                }
            }
        }
    }

    // MARK: - Subviews

    private var gameTopBar: some View {
        HStack(spacing: AppSpacing.sm) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.starMist.opacity(0.7))
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.starMist.opacity(0.08)))
            }
            .accessibilityLabel("Exit level")

            VStack(alignment: .leading, spacing: 2) {
                Text(level.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.starMist)
                Text(SkyRegion.region(for: level.id)?.name ?? "")
                    .font(.atlasCaption)
                    .foregroundColor(.starMist.opacity(0.5))
            }

            Spacer()

            HStack(spacing: AppSpacing.md) {
                HStack(spacing: 4) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 13))
                        .foregroundColor(.flareCoral.opacity(0.8))
                    Text("\(engine.mistakes)")
                        .font(.atlasSmall)
                        .foregroundColor(.flareCoral.opacity(0.9))
                }

                HStack(spacing: 4) {
                    Image(systemName: "lightbulb")
                        .font(.system(size: 13))
                        .foregroundColor(.astralGold.opacity(0.8))
                    Text("\(engine.hintsUsed)")
                        .font(.atlasSmall)
                        .foregroundColor(.astralGold.opacity(0.9))
                }

                Button {
                    engine.pause()
                    showPause = true
                } label: {
                    Image(systemName: "pause.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.starMist.opacity(0.5))
                }
                .accessibilityLabel("Pause")
            }
        }
    }

    private var gameControls: some View {
        HStack(spacing: AppSpacing.sm) {
            // Undo
            ControlButton(icon: "arrow.uturn.backward", label: "Undo", color: .starMist) {
                engine.undo()
            }
            .disabled(engine.currentRoute.isEmpty)
            .opacity(engine.currentRoute.isEmpty ? 0.3 : 1)

            // Restart
            ControlButton(icon: "arrow.clockwise", label: "Restart", color: .starMist) {
                engine.restart()
            }

            Spacer()

            // Progress indicator
            VStack(spacing: 2) {
                Text("\(engine.currentRoute.count)/\(level.correctRoute.count)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.starMist.opacity(0.6))
                ProgressView(value: engine.progressFraction)
                    .tint(.astralGold)
                    .frame(width: 60)
                    .scaleEffect(y: 0.5)
            }

            Spacer()

            // Hint
            ControlButton(icon: "lightbulb.fill", label: "Hint", color: .astralGold) {
                engine.useHint()
            }
        }
    }

    private var pauseOverlay: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                Image(systemName: "pause.circle.fill")
                    .font(.system(size: 52))
                    .foregroundColor(.astralGold)

                Text("Map Paused")
                    .font(.atlasTitle)
                    .foregroundColor(.starMist)

                VStack(spacing: AppSpacing.sm) {
                    PrimaryActionButton(title: "Resume") {
                        engine.resume()
                        showPause = false
                    }
                    SecondaryActionButton(title: "Restart Level") {
                        engine.restart()
                        showPause = false
                    }
                    SecondaryActionButton(title: "Exit to Map") {
                        dismiss()
                    }
                }
                .padding(.horizontal, AppSpacing.xl)
            }
            .padding(AppSpacing.xl)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.deepSpaceBackground.opacity(0.96))
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.starMist.opacity(0.1), lineWidth: 1))
            )
            .padding(.horizontal, AppSpacing.xl)
        }
    }

    private var completionOverlay: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.md) {
                // Header
                ZStack {
                    Circle()
                        .fill(Color.orbitGreen.opacity(0.15))
                        .frame(width: 80, height: 80)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.orbitGreen)
                }

                Text("Constellation Restored")
                    .font(.atlasTitle)
                    .foregroundColor(.starMist)

                Text(level.title)
                    .font(.atlasSection)
                    .foregroundColor(.astralGold)

                // Sky Marks
                HStack(spacing: 6) {
                    ForEach(0..<3) { i in
                        Image(systemName: i < engine.calculateSkyMarks() ? "star.fill" : "star")
                            .font(.system(size: 28))
                            .foregroundColor(i < engine.calculateSkyMarks() ? .astralGold : .starMist.opacity(0.2))
                    }
                }
                .padding(.vertical, AppSpacing.xs)

                // Stats
                HStack(spacing: AppSpacing.sm) {
                    MiniStatView(value: "\(engine.mistakes)", label: "Mistakes", color: engine.mistakes == 0 ? .orbitGreen : .flareCoral)
                    MiniStatView(value: "\(engine.hintsUsed)", label: "Hints", color: engine.hintsUsed == 0 ? .orbitGreen : .astralGold)
                    if level.hasAtlasFragment {
                        MiniStatView(
                            value: engine.fragmentCollected ? "Yes" : "No",
                            label: "Fragment",
                            color: engine.fragmentCollected ? .orbitGreen : .starMist.opacity(0.5)
                        )
                    }
                }

                if engine.isPerfectRoute() {
                    HStack(spacing: 6) {
                        Image(systemName: "seal.fill")
                            .foregroundColor(.astralGold)
                        Text("Celestial Seal Earned")
                            .font(.atlasSmall)
                            .foregroundColor(.astralGold)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Capsule().fill(Color.astralGold.opacity(0.12)))
                }

                // Buttons
                VStack(spacing: AppSpacing.sm) {
                    if let nextLevel = store.levels.first(where: { $0.id == level.id + 1 }),
                       store.isLevelUnlocked(nextLevel.id) {
                        PrimaryActionButton(title: "Next Map") {
                            showCompletion = false
                            nextLevelToPlay = nextLevel
                        }
                    }
                    HStack(spacing: AppSpacing.sm) {
                        SecondaryActionButton(title: "Replay") {
                            showCompletion = false
                            engine.restart()
                        }
                        SecondaryActionButton(title: "Star Map") {
                            showCompletion = false
                            dismiss()
                        }
                    }
                }
                .padding(.top, AppSpacing.xs)
            }
            .padding(AppSpacing.lg)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.deepSpaceBackground.opacity(0.97))
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.orbitGreen.opacity(0.2), lineWidth: 1))
            )
            .padding(.horizontal, AppSpacing.lg)
        }
        .transition(.opacity.combined(with: .scale))
    }

    // MARK: - Helpers

    private func starPosition(_ star: StarPoint, in geo: GeometryProxy) -> CGPoint {
        // 10% inset on all edges so no star is clipped at screen boundaries
        let inset: CGFloat = 20
        let usableWidth = geo.size.width - 2 * inset
        let usableHeight = geo.size.height - 2 * inset
        return CGPoint(
            x: inset + star.x * usableWidth,
            y: inset + star.y * usableHeight
        )
    }

    private func starState(_ star: StarPoint) -> StarNodeView.StarNodeState {
        if engine.wrongTapStarId == star.id { return .wrong }
        if engine.hintStarId == star.id { return .hint }
        if engine.completedConnections.contains(where: { $0.fromStarId == star.id || $0.toStarId == star.id }) {
            return .completed
        }
        if engine.currentActiveStar == star.id { return .active }
        // Highlight the first star when the game hasn't started yet
        if engine.gameState == .ready,
           let firstId = level.correctRoute.first, star.id == firstId {
            return .active
        }
        if star.isFragmentStar { return .fragment }
        return .idle
    }
}

private struct ControlButton: View {
    let icon: String
    let label: String
    var color: Color = .starMist
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(color.opacity(0.8))
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(color.opacity(0.5))
            }
            .frame(width: 54, height: 46)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.starMist.opacity(0.06))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.starMist.opacity(0.1), lineWidth: 1))
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

private struct MiniStatView: View {
    let value: String
    let label: String
    var color: Color = .starMist

    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.starMist.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.08))
        )
    }
}

#Preview {
    let level = ConstellationLevelFactory.makeAllLevels()[0]
    return ConstellationGameView(level: level)
        .environmentObject(AtlasProgressStore.shared)
}
