import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            RecordBattleView()
                .tabItem {
                    Label("記録する", systemImage: "plus.circle.fill")
                }

            BattleHistoryView()
                .tabItem {
                    Label("対戦履歴", systemImage: "list.bullet.rectangle")
                }

            BattleAnalysisView()
                .tabItem {
                    Label("結果検索", systemImage: "chart.bar.xaxis")
                }
        }
    }
}
