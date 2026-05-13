import SwiftUI

struct GlassAtlasCardView<Content: View>: View {
    let content: Content
    var padding: CGFloat = AppSpacing.md

    init(padding: CGFloat = AppSpacing.md, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.padding = padding
    }

    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: AppSpacing.cardCorner)
                    .fill(Color.starMist.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: AppSpacing.cardCorner)
                            .stroke(Color.starMist.opacity(0.12), lineWidth: 1)
                    )
            )
    }
}

struct StatTileView: View {
    let value: String
    let label: String
    var color: Color = .astralGold

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(.atlasCaption)
                .foregroundColor(.starMist.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.sm)
        .background(
            RoundedRectangle(cornerRadius: AppSpacing.chipCorner)
                .fill(color.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: AppSpacing.chipCorner)
                        .stroke(color.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

struct ProgressRingView: View {
    let progress: Double
    let total: Int
    let completed: Int
    var ringColor: Color = .astralGold
    var size: CGFloat = 80

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.starMist.opacity(0.1), lineWidth: size * 0.08)

            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    LinearGradient(
                        colors: [ringColor, ringColor.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: size * 0.08, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.8, dampingFraction: 0.7), value: progress)

            VStack(spacing: 1) {
                Text("\(completed)")
                    .font(.system(size: size * 0.22, weight: .bold))
                    .foregroundColor(.starMist)
                Text("/ \(total)")
                    .font(.system(size: size * 0.14, weight: .medium))
                    .foregroundColor(.starMist.opacity(0.5))
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: 24) {
        GlassAtlasCardView {
            Text("Card Content").foregroundColor(.starMist)
        }
        HStack(spacing: 12) {
            StatTileView(value: "42", label: "Sky Marks")
            StatTileView(value: "7", label: "Fragments", color: .orbitGreen)
        }
        ProgressRingView(progress: 0.65, total: 40, completed: 26)
    }
    .padding()
    .background(Color.deepSpaceBackground)
}
