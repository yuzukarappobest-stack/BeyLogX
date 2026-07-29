import Foundation

enum BladeSystem: String, CaseIterable, Codable, Identifiable {
    case standard = "BX / UX"
    case custom = "CX"
    case expand = "CXエクスパンド"

    var id: String { rawValue }

    var explanation: String {
        switch self {
        case .standard:
            "ブレードを1つ選択"
        case .custom:
            "ロックチップ＋メイン＋アシスト"
        case .expand:
            "ロックチップ＋オーバー＋メタル＋アシスト"
        }
    }
}

struct BeyConfiguration: Codable, Equatable, Hashable {
    var system: BladeSystem = .standard
    var blade = ""
    var lockChip = ""
    var mainBlade = ""
    var overBlade = ""
    var metalBlade = ""
    var assistBlade = ""
    var ratchet = ""
    var bit = ""

    init(
        system: BladeSystem = .standard,
        blade: String = "",
        lockChip: String = "",
        mainBlade: String = "",
        overBlade: String = "",
        metalBlade: String = "",
        assistBlade: String = "",
        ratchet: String = "",
        bit: String = ""
    ) {
        self.system = system
        self.blade = blade
        self.lockChip = lockChip
        self.mainBlade = mainBlade
        self.overBlade = overBlade
        self.metalBlade = metalBlade
        self.assistBlade = assistBlade
        self.ratchet = ratchet
        self.bit = bit
    }

    private enum CodingKeys: String, CodingKey {
        case system
        case blade
        case lockChip
        case mainBlade
        case overBlade
        case metalBlade
        case assistBlade
        case ratchet
        case bit
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        system = try container.decode(BladeSystem.self, forKey: .system)
        blade = try container.decode(String.self, forKey: .blade)
        lockChip = try container.decode(String.self, forKey: .lockChip)
        mainBlade = try container.decode(String.self, forKey: .mainBlade)
        overBlade = try container.decode(String.self, forKey: .overBlade)
        metalBlade = try container.decode(String.self, forKey: .metalBlade)
        assistBlade = try container.decode(String.self, forKey: .assistBlade)
        ratchet = try container.decode(String.self, forKey: .ratchet)
        bit = try container.decode(String.self, forKey: .bit)
    }

    var bladeDescription: String {
        let components: [String]
        switch system {
        case .standard:
            components = [blade]
        case .custom:
            components = [lockChip, mainBlade, assistBlade]
        case .expand:
            components = [lockChip, overBlade, metalBlade, assistBlade]
        }
        let value = components.filter { !$0.isEmpty }.joined(separator: " / ")
        return value.isEmpty ? "ブレード未選択" : value
    }

    var displayName: String {
        let lower = [ratchet, bit].filter { !$0.isEmpty }.joined(separator: "・")
        return lower.isEmpty ? bladeDescription : "\(bladeDescription)  \(lower)"
    }

    var isEmpty: Bool {
        blade.isEmpty &&
        lockChip.isEmpty &&
        mainBlade.isEmpty &&
        overBlade.isEmpty &&
        metalBlade.isEmpty &&
        assistBlade.isEmpty &&
        ratchet.isEmpty &&
        bit.isEmpty
    }

    var hasBladeSelection: Bool {
        switch system {
        case .standard:
            !blade.isEmpty
        case .custom:
            !lockChip.isEmpty || !mainBlade.isEmpty || !assistBlade.isEmpty
        case .expand:
            !lockChip.isEmpty || !overBlade.isEmpty || !metalBlade.isEmpty || !assistBlade.isEmpty
        }
    }

    func hasSameBlade(as other: BeyConfiguration) -> Bool {
        guard system == other.system else { return false }
        switch system {
        case .standard:
            return blade == other.blade
        case .custom:
            return lockChip == other.lockChip &&
                mainBlade == other.mainBlade &&
                assistBlade == other.assistBlade
        case .expand:
            return lockChip == other.lockChip &&
                overBlade == other.overBlade &&
                metalBlade == other.metalBlade &&
                assistBlade == other.assistBlade
        }
    }

    var analysisLockChip: String {
        guard !lockChip.isEmpty else { return "" }
        if lockChip.contains("エンペラー") {
            return "エンペラー"
        }
        if lockChip.contains("ワルキューレ") {
            return "ワルキューレ"
        }
        return "プラチップ"
    }

    func hasSameBladeForAnalysis(as other: BeyConfiguration) -> Bool {
        guard system == other.system else { return false }
        switch system {
        case .standard:
            return blade == other.blade
        case .custom:
            return analysisLockChip == other.analysisLockChip &&
                mainBlade == other.mainBlade &&
                assistBlade == other.assistBlade
        case .expand:
            return analysisLockChip == other.analysisLockChip &&
                overBlade == other.overBlade &&
                metalBlade == other.metalBlade &&
                assistBlade == other.assistBlade
        }
    }
}

enum MatchWinner: String, CaseIterable, Codable, Identifiable {
    case me = "自分の勝ち"
    case opponent = "相手の勝ち"
    case draw = "引き分け"

    var id: String { rawValue }

    var shortLabel: String {
        switch self {
        case .me: "勝ち"
        case .opponent: "負け"
        case .draw: "引分"
        }
    }

    var symbol: String {
        switch self {
        case .me: "checkmark.circle.fill"
        case .opponent: "xmark.circle.fill"
        case .draw: "minus.circle.fill"
        }
    }
}

enum FinishType: String, CaseIterable, Codable, Identifiable {
    case spin = "スピンフィニッシュ"
    case over = "オーバーフィニッシュ"
    case burst = "バーストフィニッシュ"
    case extreme = "エクストリームフィニッシュ"
    case other = "その他"

    var id: String { rawValue }

    var points: Int {
        switch self {
        case .spin: 1
        case .over, .burst: 2
        case .extreme: 3
        case .other: 0
        }
    }

    var shortLabel: String {
        switch self {
        case .spin: "スピン"
        case .over: "オーバー"
        case .burst: "バースト"
        case .extreme: "エクストリーム"
        case .other: "その他"
        }
    }
}

enum StadiumType: String, CaseIterable, Codable, Identifiable {
    case extreme = "エクストリームスタジアム"
    case infinity = "インフィニティスタジアム"

    var id: String { rawValue }

    var shortLabel: String {
        switch self {
        case .extreme: "エクストリーム"
        case .infinity: "インフィニティ"
        }
    }
}

struct BattleRecord: Identifiable, Codable, Equatable {
    let id: UUID
    let playedAt: Date
    let myBey: BeyConfiguration
    let opponentBey: BeyConfiguration
    let winner: MatchWinner
    let finish: FinishType
    let stadium: StadiumType
    let myReverseOccurred: Bool
    let opponentReverseOccurred: Bool
    let note: String

    init(
        id: UUID = UUID(),
        playedAt: Date = Date(),
        myBey: BeyConfiguration,
        opponentBey: BeyConfiguration,
        winner: MatchWinner,
        finish: FinishType,
        stadium: StadiumType = .extreme,
        myReverseOccurred: Bool = false,
        opponentReverseOccurred: Bool = false,
        note: String = ""
    ) {
        self.id = id
        self.playedAt = playedAt
        self.myBey = myBey
        self.opponentBey = opponentBey
        self.winner = winner
        self.finish = finish
        self.stadium = stadium
        self.myReverseOccurred = myReverseOccurred
        self.opponentReverseOccurred = opponentReverseOccurred
        self.note = note
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case playedAt
        case myBey
        case opponentBey
        case winner
        case finish
        case stadium
        case myReverseOccurred
        case opponentReverseOccurred
        case note
    }

    private struct LegacyReverseProbe: Decodable {
        let isReversed: Bool?
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        playedAt = try container.decode(Date.self, forKey: .playedAt)
        myBey = try container.decode(BeyConfiguration.self, forKey: .myBey)
        opponentBey = try container.decode(BeyConfiguration.self, forKey: .opponentBey)
        winner = try container.decode(MatchWinner.self, forKey: .winner)
        finish = try container.decode(FinishType.self, forKey: .finish)
        stadium = try container.decodeIfPresent(StadiumType.self, forKey: .stadium) ?? .extreme
        let legacyMyReverse = (
            try? container.decode(LegacyReverseProbe.self, forKey: .myBey)
        )?.isReversed ?? false
        let legacyOpponentReverse = (
            try? container.decode(LegacyReverseProbe.self, forKey: .opponentBey)
        )?.isReversed ?? false
        myReverseOccurred = try container.decodeIfPresent(
            Bool.self,
            forKey: .myReverseOccurred
        ) ?? legacyMyReverse
        opponentReverseOccurred = try container.decodeIfPresent(
            Bool.self,
            forKey: .opponentReverseOccurred
        ) ?? legacyOpponentReverse
        note = try container.decode(String.self, forKey: .note)
    }
}
