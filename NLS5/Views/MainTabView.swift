import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: AtlasProgressStore
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            AtlasHubView()
                .tabItem {
                    Label("Hub", systemImage: "sparkles")
                }
                .tag(0)

            StarMapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(1)

            ProgressStatsView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(3)
        }
        .tint(.astralGold)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.deepSpaceBackground)

            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.iconColor = UIColor(Color.starMist.opacity(0.4))
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.starMist.opacity(0.4))]
            itemAppearance.selected.iconColor = UIColor(Color.astralGold)
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.astralGold)]

            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AtlasProgressStore.shared)
}
