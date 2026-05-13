import SwiftUI

struct AtlasLensView: View {
    var size: CGFloat = 120
    @State private var floatOffset: CGFloat = 0
    @State private var rotationAngle: Double = 0
    @State private var pulseScale: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Outer glow ring
            Circle()
                .stroke(Color.astralGold.opacity(0.15), lineWidth: size * 0.05)
                .frame(width: size * 1.4, height: size * 1.4)
                .scaleEffect(pulseScale)

            // Orbital ring outer
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [Color.astralGold.opacity(0.4), Color.orbitGreen.opacity(0.3), Color.astralGold.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: size * 0.025
                )
                .frame(width: size * 1.2, height: size * 1.2)
                .rotationEffect(.degrees(rotationAngle))

            // Orbital ring inner
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [Color.orbitGreen.opacity(0.5), Color.astralGold.opacity(0.3)],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: size * 0.018
                )
                .frame(width: size * 0.9, height: size * 0.9)
                .rotationEffect(.degrees(-rotationAngle * 0.7))

            // Main body
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.1, green: 0.15, blue: 0.28),
                            Color.deepSpaceBackground
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: size * 0.5
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: Color.astralGold.opacity(0.3), radius: size * 0.15, x: 0, y: 0)

            // Center gold glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.astralGold.opacity(0.9), Color.astralGold.opacity(0.4), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: size * 0.2
                    )
                )
                .frame(width: size * 0.35, height: size * 0.35)

            // Cross hair lines
            Group {
                Rectangle()
                    .fill(Color.astralGold.opacity(0.4))
                    .frame(width: size * 0.6, height: 1)
                Rectangle()
                    .fill(Color.astralGold.opacity(0.4))
                    .frame(width: 1, height: size * 0.6)
            }

            // Green signal marks (4 directional dots)
            ForEach(0..<4) { i in
                Circle()
                    .fill(Color.orbitGreen)
                    .frame(width: size * 0.06, height: size * 0.06)
                    .offset(
                        x: cos(Double(i) * .pi / 2) * size * 0.45,
                        y: sin(Double(i) * .pi / 2) * size * 0.45
                    )
                    .shadow(color: Color.orbitGreen.opacity(0.8), radius: size * 0.04)
            }

            // Corner accent marks
            ForEach(0..<4) { i in
                Rectangle()
                    .fill(Color.astralGold.opacity(0.6))
                    .frame(width: size * 0.08, height: size * 0.015)
                    .offset(
                        x: cos(Double(i) * .pi / 2 + .pi / 4) * size * 0.38,
                        y: sin(Double(i) * .pi / 2 + .pi / 4) * size * 0.38
                    )
                    .rotationEffect(.degrees(Double(i) * 90 + 45))
            }
        }
        .offset(y: floatOffset)
        .onAppear {
            if !reduceMotion {
                withAnimation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true)) {
                    floatOffset = -10
                }
                withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                    rotationAngle = 360
                }
                withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                    pulseScale = 1.08
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.deepSpaceBackground.ignoresSafeArea()
        AtlasLensView(size: 140)
    }
}
