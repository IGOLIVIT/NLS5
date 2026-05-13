import SwiftUI

struct StarfieldBackgroundView: View {
    let starCount: Int
    @State private var twinklePhase: Bool = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private struct StarData: Identifiable {
        let id: Int
        let x: CGFloat
        let y: CGFloat
        let size: CGFloat
        let opacity: Double
        let twinkleOffset: Double
    }

    private let stars: [StarData]

    init(starCount: Int = 80) {
        self.starCount = starCount
        var s: [StarData] = []
        var rng = SystemRandomNumberGenerator()
        for i in 0..<starCount {
            s.append(StarData(
                id: i,
                x: CGFloat.random(in: 0...1, using: &rng),
                y: CGFloat.random(in: 0...1, using: &rng),
                size: CGFloat.random(in: 1...3, using: &rng),
                opacity: Double.random(in: 0.3...0.9, using: &rng),
                twinkleOffset: Double.random(in: 0...2, using: &rng)
            ))
        }
        self.stars = s
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()

                // Nebula soft glow patches
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.astralGold.opacity(0.04), Color.clear],
                            center: .center, startRadius: 0, endRadius: 160
                        )
                    )
                    .frame(width: 320, height: 320)
                    .position(x: geo.size.width * 0.2, y: geo.size.height * 0.3)

                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.orbitGreen.opacity(0.05), Color.clear],
                            center: .center, startRadius: 0, endRadius: 140
                        )
                    )
                    .frame(width: 280, height: 280)
                    .position(x: geo.size.width * 0.8, y: geo.size.height * 0.6)

                ForEach(stars) { star in
                    Circle()
                        .fill(Color.starMist)
                        .frame(width: star.size, height: star.size)
                        .opacity(reduceMotion ? star.opacity :
                            twinklePhase ? star.opacity : star.opacity * 0.5 + 0.2)
                        .animation(
                            reduceMotion ? nil :
                                .easeInOut(duration: 1.8 + star.twinkleOffset).repeatForever(autoreverses: true),
                            value: twinklePhase
                        )
                        .position(
                            x: star.x * geo.size.width,
                            y: star.y * geo.size.height
                        )
                }
            }
            .onAppear {
                if !reduceMotion {
                    twinklePhase = true
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct NebulaBackgroundView: View {
    var body: some View {
        ZStack {
            StarfieldBackgroundView(starCount: 60)

            // Additional nebula layer
            GeometryReader { geo in
                Ellipse()
                    .fill(
                        RadialGradient(
                            colors: [Color.astralGold.opacity(0.06), Color.clear],
                            center: .center, startRadius: 0, endRadius: 200
                        )
                    )
                    .frame(width: 400, height: 200)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.4)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    StarfieldBackgroundView()
}
