import Foundation
import Combine

@MainActor
final class BattleStore: ObservableObject {
    @Published private(set) var records: [BattleRecord] = []
    @Published var errorMessage: String?

    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(fileURL: URL? = nil) {
        let resolvedURL: URL
        if let fileURL {
            resolvedURL = fileURL
        } else {
            let directory = FileManager.default.urls(
                for: .applicationSupportDirectory,
                in: .userDomainMask
            )[0].appendingPathComponent("BeyLogX", isDirectory: true)
            resolvedURL = directory.appendingPathComponent("battles.json")
        }
        self.fileURL = resolvedURL

        encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601

        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        load()
    }

    func add(_ record: BattleRecord) {
        records.insert(record, at: 0)
        persist()
    }

    func delete(at offsets: IndexSet) {
        for offset in offsets.sorted(by: >) {
            records.remove(at: offset)
        }
        persist()
    }

    func delete(id: UUID) {
        records.removeAll { $0.id == id }
        persist()
    }

    @discardableResult
    func importJSON(_ data: Data) throws -> Int {
        let importedRecords = try BattleDataTransfer.decode(data)
        let existingIDs = Set(records.map(\.id))
        let additions = importedRecords.filter { !existingIDs.contains($0.id) }
        records.append(contentsOf: additions)
        records.sort { $0.playedAt > $1.playedAt }
        persist()
        return additions.count
    }

    private func load() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            records = try decoder.decode([BattleRecord].self, from: data)
                .sorted { $0.playedAt > $1.playedAt }
        } catch {
            errorMessage = "保存データを読み込めませんでした。\(error.localizedDescription)"
        }
    }

    private func persist() {
        do {
            try FileManager.default.createDirectory(
                at: fileURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            let data = try encoder.encode(records)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            errorMessage = "対戦結果を保存できませんでした。\(error.localizedDescription)"
        }
    }
}
