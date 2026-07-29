import XCTest
@testable import BeyLogX

final class BeyLogXTests: XCTestCase {
    func testConfigurationDescriptionUsesSelectedParts() {
        let bey = BeyConfiguration(
            system: .expand,
            lockChip: "ドラン",
            overBlade: "B（ブレイク）",
            metalBlade: "ブリッツ",
            assistBlade: "S（スラッシュ）",
            ratchet: "3-60",
            bit: "F（フラット）"
        )

        XCTAssertEqual(
            bey.bladeDescription,
            "ドラン / B（ブレイク） / ブリッツ / S（スラッシュ）"
        )
        XCTAssertTrue(bey.displayName.contains("3-60"))
    }

    func testEmptyPartsAreAllowed() {
        let bey = BeyConfiguration()

        XCTAssertTrue(bey.isEmpty)
        XCTAssertEqual(bey.displayName, "ブレード未選択")
    }

    func testCSVContainsSeparatePartColumnsAndEscapesNotes() {
        let record = BattleRecord(
            playedAt: Date(timeIntervalSince1970: 0),
            myBey: BeyConfiguration(
                system: .custom,
                lockChip: "ドラン",
                mainBlade: "ブレイブ",
                assistBlade: "S（スラッシュ）",
                ratchet: "3-60",
                bit: "F（フラット）"
            ),
            opponentBey: BeyConfiguration(),
            winner: .me,
            finish: .extreme,
            myReverseOccurred: true,
            note: "強い,再戦希望"
        )

        let csv = CSVExporter.string(for: [record])

        XCTAssertTrue(csv.contains("自分_ロックチップ"))
        XCTAssertTrue(csv.contains("自分_リバース発生"))
        XCTAssertTrue(csv.contains("ドラン"))
        XCTAssertTrue(csv.contains("エクストリームスタジアム"))
        XCTAssertTrue(csv.contains("\"強い,再戦希望\""))
    }

    func testLegacyRecordWithoutStadiumUsesExtremeStadium() throws {
        let record = BattleRecord(
            myBey: BeyConfiguration(),
            opponentBey: BeyConfiguration(),
            winner: .me,
            finish: .spin,
            stadium: .infinity
        )
        let encoded = try JSONEncoder().encode(record)
        var object = try XCTUnwrap(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        object.removeValue(forKey: "stadium")
        let legacyData = try JSONSerialization.data(withJSONObject: object)

        let decoded = try JSONDecoder().decode(BattleRecord.self, from: legacyData)

        XCTAssertEqual(decoded.stadium, .extreme)
    }

    func testLegacyConfigurationReverseMigratesToBattleEvent() throws {
        let record = BattleRecord(
            myBey: BeyConfiguration(blade: "ドランソード"),
            opponentBey: BeyConfiguration(blade: "ウィザードロッド"),
            winner: .me,
            finish: .spin
        )
        let encoded = try JSONEncoder().encode(record)
        var object = try XCTUnwrap(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        )
        var myBey = try XCTUnwrap(object["myBey"] as? [String: Any])
        var opponentBey = try XCTUnwrap(object["opponentBey"] as? [String: Any])
        object.removeValue(forKey: "myReverseOccurred")
        object.removeValue(forKey: "opponentReverseOccurred")
        myBey["isReversed"] = true
        opponentBey["isReversed"] = false
        object["myBey"] = myBey
        object["opponentBey"] = opponentBey
        let legacyData = try JSONSerialization.data(withJSONObject: object)

        let decoded = try JSONDecoder().decode(BattleRecord.self, from: legacyData)

        XCTAssertTrue(decoded.myReverseOccurred)
        XCTAssertFalse(decoded.opponentReverseOccurred)
    }

    func testPartsAreSortedWithinAlphabetAndJapaneseSyllabary() throws {
        let sorted = PartsCatalog.sorted(["か", "B", "あ", "A"])

        XCTAssertLessThan(
            try XCTUnwrap(sorted.firstIndex(of: "A")),
            try XCTUnwrap(sorted.firstIndex(of: "B"))
        )
        XCTAssertLessThan(
            try XCTUnwrap(sorted.firstIndex(of: "あ")),
            try XCTUnwrap(sorted.firstIndex(of: "か"))
        )
    }

    func testFinishPoints() {
        XCTAssertEqual(FinishType.spin.points, 1)
        XCTAssertEqual(FinishType.over.points, 2)
        XCTAssertEqual(FinishType.burst.points, 2)
        XCTAssertEqual(FinishType.extreme.points, 3)
        XCTAssertEqual(FinishType.other.points, 0)
    }

    func testJSONTransferRoundTripsRecords() throws {
        let original = BattleRecord(
            playedAt: Date(timeIntervalSince1970: 1_700_000_000),
            myBey: BeyConfiguration(
                system: .custom,
                lockChip: "エンペラー（メタル）",
                mainBlade: "ブレイブ",
                assistBlade: "S（スラッシュ）",
                ratchet: "3-60",
                bit: "F（フラット）"
            ),
            opponentBey: BeyConfiguration(blade: "ウィザードロッド"),
            winner: .me,
            finish: .extreme,
            stadium: .infinity,
            myReverseOccurred: true,
            note: "Webと共有"
        )

        let data = try BattleDataTransfer.encode([original])
        let restored = try BattleDataTransfer.decode(data)

        XCTAssertEqual(restored, [original])
    }

    func testAnalyzerFiltersByBladeAndOptionalBitAndIgnoresRatchets() throws {
        let opponentBlade = "ウィザードロッド"
        let records = [
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "3-60",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: opponentBlade,
                    ratchet: "9-60",
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .extreme
            ),
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "9-60",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: opponentBlade,
                    ratchet: "3-60",
                    bit: "B（ボール）"
                ),
                winner: .opponent,
                finish: .over
            ),
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "1-60",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: opponentBlade,
                    ratchet: "5-60",
                    bit: "B（ボール）"
                ),
                winner: .draw,
                finish: .spin
            ),
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "7-60",
                    bit: "R（ラッシュ）"
                ),
                opponentBey: BeyConfiguration(
                    blade: opponentBlade,
                    ratchet: "1-60",
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .burst
            )
        ]

        let bitFiltered = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(
                blade: "ドランソード",
                ratchet: "0-80",
                bit: "F（フラット）"
            )
        )
        let filteredSummary = try XCTUnwrap(bitFiltered.first)

        XCTAssertEqual(bitFiltered.count, 1)
        XCTAssertEqual(filteredSummary.wins, 1)
        XCTAssertEqual(filteredSummary.losses, 1)
        XCTAssertEqual(filteredSummary.draws, 1)
        XCTAssertEqual(filteredSummary.winRate, 0.5, accuracy: 0.001)
        XCTAssertEqual(filteredSummary.winPoints, 3)
        XCTAssertEqual(filteredSummary.lossPoints, 2)
        XCTAssertEqual(filteredSummary.winFinishes[.extreme], 1)
        XCTAssertEqual(filteredSummary.lossFinishes[.over], 1)
        XCTAssertEqual(filteredSummary.winFinishDescription, "エクストリーム 1回")
        XCTAssertEqual(filteredSummary.lossFinishDescription, "オーバー 1回")

        let allBits = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(blade: "ドランソード")
        )
        let allBitsSummary = try XCTUnwrap(allBits.first)

        XCTAssertEqual(allBitsSummary.wins, 2)
        XCTAssertEqual(allBitsSummary.winPoints, 5)
    }

    func testAnalyzerCombinesMyAndOpponentSidesForSelectedBey() throws {
        let records = [
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "3-60",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: "ウィザードロッド",
                    ratchet: "9-60",
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .over,
                myReverseOccurred: true,
                opponentReverseOccurred: false
            ),
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ウィザードロッド",
                    ratchet: "5-60",
                    bit: "B（ボール）"
                ),
                opponentBey: BeyConfiguration(
                    blade: "ドランソード",
                    ratchet: "1-60",
                    bit: "F（フラット）"
                ),
                winner: .me,
                finish: .extreme,
                myReverseOccurred: true,
                opponentReverseOccurred: false
            )
        ]

        let results = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(
                blade: "ウィザードロッド",
                ratchet: "0-80",
                bit: "B（ボール）"
            )
        )
        let summary = try XCTUnwrap(results.first)

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(summary.opponentBlade, "ドランソード")
        XCTAssertEqual(summary.opponentBit, "F（フラット）")
        XCTAssertEqual(summary.wins, 1)
        XCTAssertEqual(summary.losses, 1)
        XCTAssertEqual(summary.winPoints, 3)
        XCTAssertEqual(summary.lossPoints, 2)
        XCTAssertEqual(summary.winFinishes[.extreme], 1)
        XCTAssertEqual(summary.lossFinishes[.over], 1)
        XCTAssertEqual(summary.winFinishDescription, "エクストリーム 1回")
        XCTAssertEqual(summary.lossFinishDescription, "オーバー 1回")
        XCTAssertEqual(summary.reverseOccurrences, 1)
        XCTAssertEqual(summary.opponentReverseOccurrences, 1)
    }

    func testAnalysisUsesThreeCXLockChipPerformanceGroups() throws {
        let commonMain = "ブレイブ"
        let commonAssist = "S（スラッシュ）"
        let records = [
            BattleRecord(
                myBey: BeyConfiguration(blade: "ドランソード"),
                opponentBey: BeyConfiguration(
                    system: .custom,
                    lockChip: "ドラン",
                    mainBlade: commonMain,
                    assistBlade: commonAssist,
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .spin
            ),
            BattleRecord(
                myBey: BeyConfiguration(blade: "ドランソード"),
                opponentBey: BeyConfiguration(
                    system: .custom,
                    lockChip: "ヘルズ",
                    mainBlade: commonMain,
                    assistBlade: commonAssist,
                    bit: "B（ボール）"
                ),
                winner: .opponent,
                finish: .over
            ),
            BattleRecord(
                myBey: BeyConfiguration(blade: "ドランソード"),
                opponentBey: BeyConfiguration(
                    system: .custom,
                    lockChip: "エンペラー（メタル）",
                    mainBlade: commonMain,
                    assistBlade: commonAssist,
                    bit: "B（ボール）"
                ),
                winner: .opponent,
                finish: .extreme
            )
        ]

        let groupedOpponents = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(blade: "ドランソード")
        )

        XCTAssertEqual(groupedOpponents.count, 2)
        XCTAssertEqual(
            groupedOpponents.first { $0.opponentBlade.contains("プラチップ") }?.battleCount,
            2
        )
        XCTAssertEqual(
            groupedOpponents.first { $0.opponentBlade.contains("エンペラー") }?.battleCount,
            1
        )

        let plasticChipSearch = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(
                system: .custom,
                lockChip: "プラチップ",
                mainBlade: commonMain,
                assistBlade: commonAssist,
                bit: "B（ボール）"
            )
        )

        XCTAssertEqual(plasticChipSearch.reduce(0) { $0 + $1.battleCount }, 2)
    }

    func testAnalysisCountsReverseEventsWithoutChangingConfigurationGroups() throws {
        let records = [
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: "ウィザードロッド",
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .spin,
                myReverseOccurred: false,
                opponentReverseOccurred: true
            ),
            BattleRecord(
                myBey: BeyConfiguration(
                    blade: "ドランソード",
                    bit: "F（フラット）"
                ),
                opponentBey: BeyConfiguration(
                    blade: "ウィザードロッド",
                    bit: "B（ボール）"
                ),
                winner: .me,
                finish: .over,
                myReverseOccurred: true,
                opponentReverseOccurred: false
            )
        ]

        let results = BattleAnalyzer.matchups(
            records: records,
            selectedBey: BeyConfiguration(blade: "ドランソード")
        )
        let summary = try XCTUnwrap(results.first)

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(summary.battleCount, 2)
        XCTAssertEqual(summary.reverseOccurrences, 1)
        XCTAssertEqual(summary.opponentReverseOccurrences, 1)
        XCTAssertEqual(summary.reverseRate, 0.5, accuracy: 0.001)
        XCTAssertEqual(summary.opponentReverseRate, 0.5, accuracy: 0.001)
        XCTAssertEqual(summary.winPoints, 3)
    }

    @MainActor
    func testStorePersistsRecords() throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let url = directory.appendingPathComponent("test.json")
        defer { try? FileManager.default.removeItem(at: directory) }

        let store = BattleStore(fileURL: url)
        store.add(
            BattleRecord(
                myBey: BeyConfiguration(blade: "ドランソード"),
                opponentBey: BeyConfiguration(),
                winner: .me,
                finish: .spin
            )
        )

        let restored = BattleStore(fileURL: url)
        XCTAssertEqual(restored.records.count, 1)
        XCTAssertEqual(restored.records[0].myBey.blade, "ドランソード")
    }

    @MainActor
    func testStoreImportsOnlyNewJSONRecords() throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let url = directory.appendingPathComponent("test.json")
        defer { try? FileManager.default.removeItem(at: directory) }

        let existing = BattleRecord(
            myBey: BeyConfiguration(blade: "ドランソード"),
            opponentBey: BeyConfiguration(blade: "ウィザードロッド"),
            winner: .me,
            finish: .spin
        )
        let newRecord = BattleRecord(
            myBey: BeyConfiguration(blade: "ヘルズサイズ"),
            opponentBey: BeyConfiguration(blade: "ナイトシールド"),
            winner: .opponent,
            finish: .over
        )
        let store = BattleStore(fileURL: url)
        store.add(existing)

        let count = try store.importJSON(
            BattleDataTransfer.encode([existing, newRecord])
        )

        XCTAssertEqual(count, 1)
        XCTAssertEqual(store.records.count, 2)
    }
}
