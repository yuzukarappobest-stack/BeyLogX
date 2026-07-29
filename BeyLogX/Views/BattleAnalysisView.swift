import SwiftUI

struct BattleAnalysisView: View {
    @EnvironmentObject private var store: BattleStore
    @State private var selectedBey = BeyConfiguration()

    private var summaries: [MatchupSummary] {
        BattleAnalyzer.matchups(
            records: store.records,
            selectedBey: selectedBey
        )
    }

    private var matchedBattleCount: Int {
        summaries.reduce(0) { $0 + $1.battleCount }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    searchCard

                    if !selectedBey.hasBladeSelection {
                        prompt
                    } else if summaries.isEmpty {
                        noResults
                    } else {
                        resultsHeader
                        ForEach(summaries) { summary in
                            MatchupSummaryCard(summary: summary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("結果検索")
        }
    }

    private var searchCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color("AccentColor"))
                    .frame(width: 38, height: 38)
                    .background(
                        Color("AccentColor").opacity(0.14),
                        in: RoundedRectangle(cornerRadius: 11)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("ベイの対戦成績を検索")
                        .font(.headline)
                    Text("自分・相手を区別せず集計")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            VStack(spacing: 0) {
                HStack {
                    Text("シリーズ")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Picker("シリーズ", selection: $selectedBey.system) {
                        ForEach(BladeSystem.allCases) { system in
                            Text(system.rawValue).tag(system)
                        }
                    }
                    .labelsHidden()
                }
                .frame(minHeight: 44)

                Divider()

                switch selectedBey.system {
                case .standard:
                    AnalysisPartPickerRow(
                        title: "ブレード",
                        selection: $selectedBey.blade,
                        options: PartsCatalog.standardBlades
                    )
                case .custom:
                    AnalysisPartPickerRow(
                        title: "ロックチップ",
                        selection: $selectedBey.lockChip,
                        options: PartsCatalog.analysisLockChips
                    )
                    Divider()
                    AnalysisPartPickerRow(
                        title: "メインブレード",
                        selection: $selectedBey.mainBlade,
                        options: PartsCatalog.mainBlades
                    )
                    Divider()
                    AnalysisPartPickerRow(
                        title: "アシストブレード",
                        selection: $selectedBey.assistBlade,
                        options: PartsCatalog.assistBlades
                    )
                case .expand:
                    AnalysisPartPickerRow(
                        title: "ロックチップ",
                        selection: $selectedBey.lockChip,
                        options: PartsCatalog.analysisLockChips
                    )
                    Divider()
                    AnalysisPartPickerRow(
                        title: "オーバーブレード",
                        selection: $selectedBey.overBlade,
                        options: PartsCatalog.overBlades
                    )
                    Divider()
                    AnalysisPartPickerRow(
                        title: "メタルブレード",
                        selection: $selectedBey.metalBlade,
                        options: PartsCatalog.metalBlades
                    )
                    Divider()
                    AnalysisPartPickerRow(
                        title: "アシストブレード",
                        selection: $selectedBey.assistBlade,
                        options: PartsCatalog.assistBlades
                    )
                }

                Divider()

                AnalysisPartPickerRow(
                    title: "ビット",
                    selection: $selectedBey.bit,
                    options: PartsCatalog.bits,
                    blankLabel: "指定しない"
                )
            }

            Label(
                "ラチェットは検索条件・相手の集計キーに含めません",
                systemImage: "info.circle"
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.quaternary, lineWidth: 1)
        }
        .onChange(of: selectedBey.system) { _, system in
            clearHiddenComponents(for: system)
        }
    }

    private var prompt: some View {
        ContentUnavailableView {
            Label("ブレードを選択", systemImage: "square.stack.3d.up")
        } description: {
            Text("選択すると、そのベイがどのベイに勝ったか・負けたかを表示します。")
        }
        .frame(minHeight: 260)
    }

    private var noResults: some View {
        ContentUnavailableView.search(text: selectedBey.displayName)
            .frame(minHeight: 260)
    }

    private var resultsHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("選択したベイの対戦成績")
                    .font(.headline)
                Text("\(matchedBattleCount)件の対戦・\(summaries.count)種類の相手構成")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.top, 4)
    }

    private func clearHiddenComponents(for system: BladeSystem) {
        switch system {
        case .standard:
            selectedBey.lockChip = ""
            selectedBey.mainBlade = ""
            selectedBey.overBlade = ""
            selectedBey.metalBlade = ""
            selectedBey.assistBlade = ""
        case .custom:
            selectedBey.blade = ""
            selectedBey.overBlade = ""
            selectedBey.metalBlade = ""
        case .expand:
            selectedBey.blade = ""
            selectedBey.mainBlade = ""
        }
    }
}

private struct AnalysisPartPickerRow: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    var blankLabel = "未選択"

    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer(minLength: 8)
            Picker(title, selection: $selection) {
                Text(blankLabel).tag("")
                ForEach(PartsCatalog.sorted(options), id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .lineLimit(1)
        }
        .frame(minHeight: 44)
    }
}

private struct MatchupSummaryCard: View {
    let summary: MatchupSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(summary.opponentBlade)
                    .font(.headline)
                    .lineLimit(2)
                Text(summary.opponentBit.isEmpty ? "ビット未選択" : summary.opponentBit)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(
                        Color(uiColor: .secondarySystemGroupedBackground),
                        in: Capsule()
                    )
            }

            Divider()

            HStack(spacing: 8) {
                AnalysisMetric(
                    value: "\(summary.wins)勝 \(summary.losses)敗",
                    label: summary.draws > 0 ? "引分 \(summary.draws)" : "勝敗数",
                    color: .primary
                )
                AnalysisMetric(
                    value: summary.winRate.formatted(
                        .percent.precision(.fractionLength(1))
                    ),
                    label: "勝率",
                    color: .blue
                )
            }

            HStack(spacing: 8) {
                AnalysisMetric(
                    value: "\(summary.winPoints)",
                    label: "勝ちポイント合計",
                    color: .green
                )
                AnalysisMetric(
                    value: "\(summary.lossPoints)",
                    label: "負けポイント合計",
                    color: .red
                )
            }

            Divider()

            FinishBreakdownRow(
                title: "勝ち方",
                description: summary.winFinishDescription,
                symbol: "checkmark.circle.fill",
                color: .green
            )

            FinishBreakdownRow(
                title: "負け方",
                description: summary.lossFinishDescription,
                symbol: "xmark.circle.fill",
                color: .red
            )

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Label("リバース発生", systemImage: "arrow.uturn.backward.circle.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.orange)

                ReverseOccurrenceRow(
                    title: "検索したベイ",
                    count: summary.reverseOccurrences,
                    battleCount: summary.battleCount,
                    rate: summary.reverseRate
                )
                ReverseOccurrenceRow(
                    title: "対戦したベイ",
                    count: summary.opponentReverseOccurrences,
                    battleCount: summary.battleCount,
                    rate: summary.opponentReverseRate
                )
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 18))
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.quaternary, lineWidth: 1)
        }
    }
}

private struct ReverseOccurrenceRow: View {
    let title: String
    let count: Int
    let battleCount: Int
    let rate: Double

    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(count)回 / \(battleCount)戦")
                .font(.subheadline.weight(.semibold))
            Text(
                rate.formatted(.percent.precision(.fractionLength(1)))
            )
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(width: 52, alignment: .trailing)
        }
    }
}

private struct FinishBreakdownRow: View {
    let title: String
    let description: String
    let symbol: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(description)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
    }
}

private struct AnalysisMetric: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.headline)
                .foregroundStyle(color)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 11)
        .background(
            Color(uiColor: .secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}
