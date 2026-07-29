import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct BattleJSONDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }

    private let data: Data

    init(records: [BattleRecord]) {
        data = (try? BattleDataTransfer.encode(records)) ?? Data("[]".utf8)
    }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}

enum BattleDataTransfer {
    static func encode(_ records: [BattleRecord]) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(records)
    }

    static func decode(_ data: Data) throws -> [BattleRecord] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([BattleRecord].self, from: data)
    }
}
