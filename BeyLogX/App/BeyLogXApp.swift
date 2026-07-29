import SwiftUI

@main
struct BeyLogXApp: App {
    @StateObject private var store = BattleStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .tint(Color("AccentColor"))
        }
    }
}

