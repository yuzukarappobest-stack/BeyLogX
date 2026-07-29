import SwiftUI

struct BattleDetailView: View {
    @EnvironmentObject private var store: BattleStore
    @Environment(\.dismiss) private var dismiss
    let record: BattleRecord

    @State private var confirmDelete = false

    var body: some View {
        List {
            Section {
                HStack(spacing: 12) {
                    Image(systemName: record.winner.symbol)
                        .font(.title2)
                        .foregroundStyle(resultColor)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(record.winner.rawValue)
                            .font(.headline)
                        Text(record.finish.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                LabeledContent("対戦日時") {
                    Text(record.playedAt.formatted(date: .long, time: .shortened))
                }
                LabeledContent("スタジアム", value: record.stadium.rawValue)
                LabeledContent(
                    "自分のリバース",
                    value: record.myReverseOccurred ? "有" : "無"
                )
                LabeledContent(
                    "相手のリバース",
                    value: record.opponentReverseOccurred ? "有" : "無"
                )
            }

            BeyDetailSection(title: "自分のベイ", bey: record.myBey)
            BeyDetailSection(title: "相手のベイ", bey: record.opponentBey)

            if !record.note.isEmpty {
                Section("メモ") {
                    Text(record.note)
                }
            }
        }
        .navigationTitle("対戦の詳細")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    confirmDelete = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .confirmationDialog(
            "この対戦記録を削除しますか？",
            isPresented: $confirmDelete,
            titleVisibility: .visible
        ) {
            Button("削除", role: .destructive) {
                store.delete(id: record.id)
                dismiss()
            }
        }
    }

    private var resultColor: Color {
        switch record.winner {
        case .me: .green
        case .opponent: .red
        case .draw: .gray
        }
    }
}

private struct BeyDetailSection: View {
    let title: String
    let bey: BeyConfiguration

    var body: some View {
        Section(title) {
            LabeledContent("シリーズ", value: bey.system.rawValue)
            switch bey.system {
            case .standard:
                valueRow("ブレード", bey.blade)
            case .custom:
                valueRow("ロックチップ", bey.lockChip)
                valueRow("メインブレード", bey.mainBlade)
                valueRow("アシストブレード", bey.assistBlade)
            case .expand:
                valueRow("ロックチップ", bey.lockChip)
                valueRow("オーバーブレード", bey.overBlade)
                valueRow("メタルブレード", bey.metalBlade)
                valueRow("アシストブレード", bey.assistBlade)
            }
            valueRow("ラチェット", bey.ratchet)
            valueRow("ビット", bey.bit)
        }
    }

    private func valueRow(_ label: String, _ value: String) -> some View {
        LabeledContent(label, value: value.isEmpty ? "未選択" : value)
    }
}
