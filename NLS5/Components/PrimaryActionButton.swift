import SwiftUI

struct PrimaryActionButton: View {
    let title: String
    let action: () -> Void
    var isDestructive: Bool = false
    var isFullWidth: Bool = true
    @State private var pressed: Bool = false

    var body: some View {
        Button(action: {
            pressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { pressed = false }
            action()
        }) {
            Text(title)
                .font(.atlasButton)
                .foregroundColor(isDestructive ? .white : .deepSpaceBackground)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .frame(height: AppSpacing.buttonHeight)
                .padding(.horizontal, isFullWidth ? 0 : AppSpacing.xl)
                .background(
                    RoundedRectangle(cornerRadius: AppSpacing.buttonCorner)
                        .fill(isDestructive ? Color.flareCoral : Color.astralGold)
                        .shadow(color: (isDestructive ? Color.flareCoral : Color.astralGold).opacity(0.4), radius: 8, x: 0, y: 4)
                )
        }
        .scaleEffect(pressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.2, dampingFraction: 0.7), value: pressed)
        .accessibilityLabel(title)
    }
}

struct SecondaryActionButton: View {
    let title: String
    let action: () -> Void
    var isFullWidth: Bool = true
    @State private var pressed: Bool = false

    var body: some View {
        Button(action: {
            pressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { pressed = false }
            action()
        }) {
            Text(title)
                .font(.atlasButton)
                .foregroundColor(.starMist)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .frame(height: AppSpacing.secondaryButtonHeight)
                .padding(.horizontal, isFullWidth ? 0 : AppSpacing.xl)
                .background(
                    RoundedRectangle(cornerRadius: AppSpacing.buttonCorner)
                        .stroke(Color.starMist.opacity(0.3), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: AppSpacing.buttonCorner)
                                .fill(Color.starMist.opacity(0.06))
                        )
                )
        }
        .scaleEffect(pressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.2, dampingFraction: 0.7), value: pressed)
        .accessibilityLabel(title)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryActionButton(title: "Continue Map") {}
        SecondaryActionButton(title: "How to Play") {}
        PrimaryActionButton(title: "Reset Progress", action: {}, isDestructive: true)
    }
    .padding()
    .background(Color.deepSpaceBackground)
}
