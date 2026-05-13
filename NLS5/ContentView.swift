import SwiftUI

struct ContentView: View {
    @StateObject private var store = AtlasProgressStore.shared

    var body: some View {
        Group {
            if store.onboardingCompleted {
                MainTabView()
                    .environmentObject(store)
            } else {
                OnboardingView()
                    .environmentObject(store)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
