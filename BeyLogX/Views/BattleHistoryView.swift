import SwiftUI
import UniformTypeIdentifiers

struct BattleHistoryView: View {
    @EnvironmentObject private var store: BattleStore
    @State private var isExportingCSV = false
    @State private var isExportingJSON = false
    @State private var isImportingJSON = false
    @State private var importMessage: String?

    private var wins: Int { store.records.count { $0.winner == .me } }
    private var losses: Int { store.records.count { $0.winner == .opponent } }

    var body: some View {
        NavigationStack {
            Group {
                if store.records.isEmpty {
                    ContentUnavailableView {
                        Label("対戦記録がありません", systemImage: "list.bullet.clipboard")
                    } description: {
                        Text("「記録する」タブから最初の対戦を保存しましょう。")
                    }
                } else {
                    List {
                        Section {
                            summary
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }

                        Section("記録") {
                            ForEach(store.records) { record in
                                NavigationLink {
                                    BattleDetailView(record: record)
                                } label: {
                                    BattleRow(record: record)
                                }
                            }
                            .onDelete(perform: store.delete)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("対戦履歴")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            isExportingJSON = true
                        } label: {
                            Label("JSONバックアップを書き出す", systemImage: "square.and.arrow.up")
                        }
                        .disabled(store.records.isEmpty)

                        Button {
                            isImportingJSON = true
                        } label: {
                            Label("JSONバックアップを読み込む", systemImage: "square.and.arrow.down")
                        }

                        Divider()

                        Button {
                            isExportingCSV = true
                        } label: {
                            Label("CSVを書き出す", systemImage: "tablecells")
                        }
                        .disabled(store.records.isEmpty)
                    } label: {
                        Label("データ", systemImage: "ellipsis.circle")
                    }
                }
            }
            .fileExporter(
                isPresented: $isExportingCSV,
                document: BattleCSVDocument(records: store.records),
                contentType: .commaSeparatedText,
                defaultFilename: "\(exportFilename).csv"
            ) { result in
                if case .failure(let error) = result {
                    store.errorMessage = "CSVを書き出せませんでした。\(error.localizedDescription)"
                }
            }
            .fileExporter(
                isPresented: $isExportingJSON,
                document: BattleJSONDocument(records: store.records),
                contentType: .json,
                defaultFilename: "\(exportFilename).json"
            ) { result in
                if case .failure(let error) = result {
                    store.errorMessage = "JSONを書き出せませんでした。\(error.localizedDescription)"
                }
            }
            .fileImporter(
                isPresented: $isImportingJSON,
                allowedContentTypes: [.json],
                allowsMultipleSelection: false
            ) { result in
                importJSON(result)
            }
            .alert(
                "エラー",
                isPresented: Binding(
                    get: { store.errorMessage != nil },
                    set: { if !$0 { store.errorMessage = nil } }
                )
            ) {
                Button("OK") { store.errorMessage = nil }
            } message: {
                Text(store.errorMessage ?? "")
            }
            .alert(
                "読み込み完了",
                isPresented: Binding(
                    get: { importMessage != nil },
                    set: { if !$0 { importMessage = nil } }
                )
            ) {
                Button("OK") { importMessage = nil }
            } message: {
                Text(importMessage ?? "")
            }
        }
    }

    private var summary: some View {
        HStack(spacing: 10) {
            SummaryTile(value: "\(store.records.count)", label: "対戦", color: .blue)
            SummaryTile(value: "\(wins)", label: "勝ち", color: .green)
            SummaryTile(value: "\(losses)", label: "負け", color: .red)
        }
        .padding(.vertical, 8)
    }

    private var exportFilename: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return "BeyLogX_\(formatter.string(from: Date()))"
    }

    private func importJSON(_ result: Result<[URL], Error>) {
        do {
            let url = try result.get().first
            guard let url else { return }
            let hasAccess = url.startAccessingSecurityScopedResource()
            defer {
                if hasAccess {
                    url.stopAccessingSecurityScopedResource()
                }
            }
            let data = try Data(contentsOf: url)
            let count = try store.importJSON(data)
            importMessage = count == 0
                ? "新しい対戦記録はありませんでした。"
                : "\(count)件の対戦記録を追加しました。"
        } catch {
            store.errorMessage = "JSONを読み込めませんでした。\(error.localizedDescription)"
        }
    }
}

private struct SummaryTile: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(color)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct BattleRow: View {
    let record: BattleRecord

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: record.winner.symbol)
                .font(.title2)
                .foregroundStyle(resultColor)

            VStack(alignment: .leading, spacing: 5) {
                Text(record.myBey.displayName)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                HStack(spacing: 5) {
                    Text("vs")
                    Text(record.opponentBey.displayName)
                        .lineLimit(1)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                Text("\(record.finish.rawValue)・\(record.playedAt.formatted(date: .numeric, time: .shortened))")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }

    private var resultColor: Color {
        switch record.winner {
        case .me: .green
        case .opponent: .red
        case .draw: .gray
        }
    }
}
