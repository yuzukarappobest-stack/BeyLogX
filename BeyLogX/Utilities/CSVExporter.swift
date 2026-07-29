import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct BattleCSVDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.commaSeparatedText] }

    private let data: Data

    init(records: [BattleRecord]) {
        data = CSVExporter.data(for: records)
    }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}

enum CSVExporter {
    static let header = [
        "日時", "スタジアム", "勝敗", "決まり手",
        "自分_リバース発生", "相手_リバース発生",
        "自分_システム", "自分_ブレード", "自分_ロックチップ", "自分_メインブレード",
        "自分_オーバーブレード", "自分_メタルブレード", "自分_アシストブレード",
        "自分_ラチェット", "自分_ビット",
        "相手_システム", "相手_ブレード", "相手_ロックチップ", "相手_メインブレード",
        "相手_オーバーブレード", "相手_メタルブレード", "相手_アシストブレード",
        "相手_ラチェット", "相手_ビット", "メモ"
    ]

    static func string(for records: [BattleRecord]) -> String {
        let formatter = ISO8601DateFormatter()
        let rows = records.map { record in
            let values = [
                formatter.string(from: record.playedAt),
                record.stadium.rawValue,
                record.winner.rawValue,
                record.finish.rawValue,
                record.myReverseOccurred ? "有" : "無",
                record.opponentReverseOccurred ? "有" : "無"
            ] + values(for: record.myBey) + values(for: record.opponentBey) + [record.note]
            return values.map(escape).joined(separator: ",")
        }
        return ([header.map(escape).joined(separator: ",")] + rows).joined(separator: "\r\n")
    }

    static func data(for records: [BattleRecord]) -> Data {
        // UTF-8 BOM makes Japanese text open correctly in common spreadsheet apps.
        Data([0xEF, 0xBB, 0xBF]) + Data(string(for: records).utf8)
    }

    private static func values(for bey: BeyConfiguration) -> [String] {
        [
            bey.system.rawValue, bey.blade, bey.lockChip, bey.mainBlade,
            bey.overBlade, bey.metalBlade, bey.assistBlade, bey.ratchet, bey.bit
        ]
    }

    private static func escape(_ value: String) -> String {
        guard value.contains(",") || value.contains("\"") || value.contains("\n") || value.contains("\r")
        else { return value }
        return "\"\(value.replacingOccurrences(of: "\"", with: "\"\""))\""
    }
}
