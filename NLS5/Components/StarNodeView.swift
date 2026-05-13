import SwiftUI

struct StarNodeView: View {
    let star: StarPoint
    let state: StarNodeState
    var onTap: () -> Void
    @State private var pulseScale: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    enum StarNodeState {
        case idle
        case active
        case completed
        case hint
        case wrong
        case fragment
    }

    private var nodeColor: Color {
        switch state {
        case .idle: return Color.starMist.opacity(0.8)
        case .active: return Color.astralGold
        case .completed: return Color.orbitGreen
        case .hint: return Color.astralGold
        case .wrong: return Color.flareCoral
        case .fragment: return Color.orbitGreen
        }
    }

    private var glowColor: Color {
        switch state {
        case .idle: return Color.starMist.opacity(0.2)
        case .active: return Color.astralGold.opacity(0.6)
        case .completed: return Color.orbitGreen.opacity(0.5)
        case .hint: return Color.astralGold.opacity(0.8)
        case .wrong: return Color.flareCoral.opacity(0.7)
        case .fragment: return Color.orbitGreen.opacity(0.7)
        }
    }

    private var nodeSize: CGFloat {
        let base: CGFloat = 16
        return base * star.size
    }

    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(glowColor)
                .frame(width: nodeSize * 2.4, height: nodeSize * 2.4)
                .scaleEffect(pulseScale)
                .opacity(state == .idle ? 0 : 1)

            // Wrong tap coral burst
            if state == .wrong {
                Circle()
                    .fill(Color.flareCoral.opacity(0.3))
                    .frame(width: nodeSize * 3.5, height: nodeSize * 3.5)
                    .scaleEffect(pulseScale)
            }

            // Fragment ring
            if star.isFragmentStar {
                Circle()
                    .stroke(Color.orbitGreen.opacity(0.7), lineWidth: 1.5)
                    .frame(width: nodeSize * 2.0, height: nodeSize * 2.0)
                    .rotationEffect(.degrees(pulseScale > 1 ? 45 : 0))
            }

            // Main star dot
            Circle()
                .fill(nodeColor)
                .frame(width: nodeSize, height: nodeSize)
                .shadow(color: glowColor, radius: 4)

            // Inner bright center
            Circle()
                .fill(Color.white.opacity(state == .idle ? 0.6 : 0.9))
                .frame(width: nodeSize * 0.4, height: nodeSize * 0.4)
        }
        .frame(width: nodeSize * 3.5, height: nodeSize * 3.5)
        .contentShape(Circle().size(CGSize(width: nodeSize * 3.5, height: nodeSize * 3.5)))
        .onTapGesture(perform: onTap)
        .onAppear {
            guard !reduceMotion else { return }
            switch state {
            case .active, .hint:
                withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    pulseScale = 1.25
                }
            case .wrong:
                withAnimation(.easeOut(duration: 0.5)) {
                    pulseScale = 1.4
                }
            case .fragment:
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    pulseScale = 1.15
                }
            default:
                break
            }
        }
        .onChange(of: state) { _, newState in
            guard !reduceMotion else { return }
            pulseScale = 1.0
            switch newState {
            case .active, .hint:
                withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    pulseScale = 1.25
                }
            case .wrong:
                withAnimation(.easeOut(duration: 0.5)) {
                    pulseScale = 1.4
                }
            default:
                break
            }
        }
        .accessibilityLabel("Star \(star.id + 1)\(star.isFragmentStar ? ", Atlas Fragment" : "")")
        .accessibilityAddTraits(.isButton)
    }
}

struct ConstellationLineView: View {
    let from: CGPoint
    let to: CGPoint
    var color: Color = .astralGold
    @State private var drawProgress: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Canvas { context, _ in
            var path = Path()
            path.move(to: from)
            let end = CGPoint(
                x: from.x + (to.x - from.x) * drawProgress,
                y: from.y + (to.y - from.y) * drawProgress
            )
            path.addLine(to: end)

            context.stroke(
                path,
                with: .color(color.opacity(0.85)),
                style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
            )

            // Glow layer
            context.stroke(
                path,
                with: .color(color.opacity(0.3)),
                style: StrokeStyle(lineWidth: 5, lineCap: .round)
            )
        }
        .allowsHitTesting(false)
        .onAppear {
            if reduceMotion {
                drawProgress = 1.0
            } else {
                withAnimation(.easeOut(duration: 0.35)) {
                    drawProgress = 1.0
                }
            }
        }
    }
}

struct RegionBadgeView: View {
    let region: SkyRegion
    let isCompleted: Bool
    let isUnlocked: Bool

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(
                        isCompleted ? Color.orbitGreen.opacity(0.2) :
                        isUnlocked ? Color.astralGold.opacity(0.1) :
                        Color.starMist.opacity(0.05)
                    )
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle()
                            .stroke(
                                isCompleted ? Color.orbitGreen.opacity(0.6) :
                                isUnlocked ? Color.astralGold.opacity(0.4) :
                                Color.starMist.opacity(0.15),
                                lineWidth: 1.5
                            )
                    )

                Image(systemName: isCompleted ? "seal.fill" : isUnlocked ? "star.fill" : "lock.fill")
                    .font(.system(size: 18))
                    .foregroundColor(
                        isCompleted ? .orbitGreen :
                        isUnlocked ? .astralGold :
                        .starMist.opacity(0.3)
                    )
            }
            Text(region.name)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.starMist.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

struct LevelCardView: View {
    let level: ConstellationLevel
    let result: LevelResult?
    let isUnlocked: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: AppSpacing.md) {
                // Level number badge
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(levelBadgeColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    Text("\(level.id)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(levelBadgeColor)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(level.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(isUnlocked ? .starMist : .starMist.opacity(0.35))
                    HStack(spacing: 6) {
                        Text(level.difficulty.displayName)
                            .font(.atlasCaption)
                            .foregroundColor(difficultyColor.opacity(0.8))
                        if level.hasAtlasFragment {
                            Image(systemName: result?.fragmentCollected == true ? "doc.text.fill" : "doc.text")
                                .font(.system(size: 10))
                                .foregroundColor(result?.fragmentCollected == true ? .orbitGreen : .starMist.opacity(0.4))
                        }
                    }
                }

                Spacer()

                if !isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.starMist.opacity(0.3))
                } else if let result = result {
                    skyMarkView(marks: result.bestSkyMarks)
                } else {
                    Image(systemName: "circle.dashed")
                        .font(.system(size: 16))
                        .foregroundColor(.starMist.opacity(0.3))
                }
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.sm)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.starMist.opacity(result != nil ? 0.07 : 0.03))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                result != nil ? Color.astralGold.opacity(0.15) : Color.starMist.opacity(0.08),
                                lineWidth: 1
                            )
                    )
            )
        }
        .buttonStyle(.plain)
        .disabled(!isUnlocked)
    }

    @ViewBuilder
    private func skyMarkView(marks: Int) -> some View {
        HStack(spacing: 2) {
            ForEach(0..<3) { i in
                Image(systemName: i < marks ? "star.fill" : "star")
                    .font(.system(size: 10))
                    .foregroundColor(i < marks ? .astralGold : .starMist.opacity(0.2))
            }
        }
    }

    private var levelBadgeColor: Color {
        if !isUnlocked { return .starMist.opacity(0.3) }
        if result != nil { return .orbitGreen }
        return .astralGold
    }

    private var difficultyColor: Color {
        switch level.difficulty {
        case .beginner: return .orbitGreen
        case .easy: return .astralGold
        case .medium: return Color(red: 0.9, green: 0.7, blue: 0.3)
        case .hard: return Color.flareCoral.opacity(0.9)
        case .expert: return Color.flareCoral
        }
    }
}
