import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) private var dismiss

    private let instructions: [Instruction] = [
        Instruction(
            icon: "hand.tap.fill",
            title: "Tap the first star",
            text: "Begin each constellation by tapping the correct starting star. It will glow to indicate selection.",
            color: .astralGold
        ),
        Instruction(
            icon: "line.diagonal",
            title: "Follow the glowing route",
            text: "Each correct tap draws a glowing path between stars. Continue tapping stars in the correct order.",
            color: .astralGold
        ),
        Instruction(
            icon: "xmark.circle",
            title: "Avoid wrong stars",
            text: "Tapping the wrong star creates a warning flash and adds a mistake. Fewer mistakes earn more Sky Marks.",
            color: .flareCoral
        ),
        Instruction(
            icon: "lightbulb.fill",
            title: "Use hints carefully",
            text: "Tap the hint button to briefly highlight the next correct star. Using hints reduces your Sky Marks.",
            color: Color(red: 0.9, green: 0.8, blue: 0.3)
        ),
        Instruction(
            icon: "doc.text.fill",
            title: "Collect atlas fragments",
            text: "Some constellations contain special marked stars. Connect them in sequence to collect Atlas Fragments.",
            color: .orbitGreen
        ),
        Instruction(
            icon: "map.fill",
            title: "Restore each region",
            text: "Complete all constellations in a Sky Region to earn a Region Badge and unlock the next celestial territory.",
            color: .orbitGreen
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.deepSpaceBackground.ignoresSafeArea()
                StarfieldBackgroundView(starCount: 40)

                ScrollView {
                    VStack(spacing: AppSpacing.md) {
                        // Lens illustration
                        AtlasLensView(size: 90)
                            .padding(.vertical, AppSpacing.md)

                        // Instructions
                        ForEach(Array(instructions.enumerated()), id: \.offset) { _, instruction in
                            InstructionCard(instruction: instruction)
                                .padding(.horizontal, AppSpacing.lg)
                        }

                        // Scoring section
                        GlassAtlasCardView {
                            VStack(alignment: .leading, spacing: AppSpacing.md) {
                                HStack(spacing: AppSpacing.sm) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.astralGold)
                                        .font(.system(size: 18))
                                    Text("Sky Marks Scoring")
                                        .font(.atlasSection)
                                        .foregroundColor(.starMist)
                                }

                                ForEach(SkyMarkRule.all) { rule in
                                    HStack(spacing: AppSpacing.sm) {
                                        HStack(spacing: 3) {
                                            ForEach(0..<3) { i in
                                                Image(systemName: i < rule.marks ? "star.fill" : "star")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(i < rule.marks ? .astralGold : .starMist.opacity(0.2))
                                            }
                                        }
                                        .frame(width: 52, alignment: .leading)
                                        Text(rule.description)
                                            .font(.atlasBody)
                                            .foregroundColor(.starMist.opacity(0.7))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)
                        .padding(.bottom, AppSpacing.xl)
                    }
                    .padding(.top, AppSpacing.sm)
                }
            }
            .navigationTitle("How to Play")
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

private struct Instruction {
    let icon: String
    let title: String
    let text: String
    let color: Color
}

private struct InstructionCard: View {
    let instruction: Instruction

    var body: some View {
        GlassAtlasCardView {
            HStack(alignment: .top, spacing: AppSpacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(instruction.color.opacity(0.12))
                        .frame(width: 44, height: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(instruction.color.opacity(0.3), lineWidth: 1)
                        )
                    Image(systemName: instruction.icon)
                        .font(.system(size: 18))
                        .foregroundColor(instruction.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(instruction.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.starMist)
                    Text(instruction.text)
                        .font(.atlasBody)
                        .foregroundColor(.starMist.opacity(0.65))
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

private struct SkyMarkRule: Identifiable {
    let id: Int
    let marks: Int
    let description: String

    static let all: [SkyMarkRule] = [
        SkyMarkRule(id: 1, marks: 3, description: "No mistakes and no hints used"),
        SkyMarkRule(id: 2, marks: 2, description: "Up to 2 mistakes or 1 hint used"),
        SkyMarkRule(id: 3, marks: 1, description: "Level completed")
    ]
}

#Preview {
    HowToPlayView()
}
