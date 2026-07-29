import Foundation

struct MatchupSummary: Identifiable, Equatable {
    let id: String
    let opponentBlade: String
    let opponentBit: String
    let wins: Int
    let losses: Int
    let draws: Int
    let winPoints: Int
    let lossPoints: Int
    let winFinishes: [FinishType: Int]
    let lossFinishes: [FinishType: Int]
    let reverseOccurrences: Int
    let opponentReverseOccurrences: Int

    var battleCount: Int { wins + losses + draws }

    var winRate: Double {
        let decidedBattles = wins + losses
        guard decidedBattles > 0 else { return 0 }
        return Double(wins) / Double(decidedBattles)
    }

    var reverseRate: Double {
        guard battleCount > 0 else { return 0 }
        return Double(reverseOccurrences) / Double(battleCount)
    }

    var opponentReverseRate: Double {
        guard battleCount > 0 else { return 0 }
        return Double(opponentReverseOccurrences) / Double(battleCount)
    }

    var opponentDisplayName: String {
        let bitName = opponentBit.isEmpty ? "ビット未選択" : opponentBit
        return "\(opponentBlade)  \(bitName)"
    }

    var winFinishDescription: String {
        finishDescription(for: winFinishes)
    }

    var lossFinishDescription: String {
        finishDescription(for: lossFinishes)
    }

    private func finishDescription(for counts: [FinishType: Int]) -> String {
        let values = FinishType.allCases.compactMap { finish -> String? in
            guard let count = counts[finish], count > 0 else { return nil }
            return "\(finish.shortLabel) \(count)回"
        }
        return values.isEmpty ? "なし" : values.joined(separator: "・")
    }
}

enum BattleAnalyzer {
    static func matchups(
        records: [BattleRecord],
        selectedBey: BeyConfiguration
    ) -> [MatchupSummary] {
        guard selectedBey.hasBladeSelection else { return [] }

        var aggregates: [OpponentKey: Aggregate] = [:]

        for record in records {
            if matches(record.myBey, selectedBey: selectedBey) {
                add(
                    opposingBey: record.opponentBey,
                    result: result(for: record.winner, searchedSide: .me),
                    finish: record.finish,
                    reverseOccurred: record.myReverseOccurred,
                    opposingReverseOccurred: record.opponentReverseOccurred,
                    to: &aggregates
                )
            }

            if matches(record.opponentBey, selectedBey: selectedBey) {
                add(
                    opposingBey: record.myBey,
                    result: result(for: record.winner, searchedSide: .opponent),
                    finish: record.finish,
                    reverseOccurred: record.opponentReverseOccurred,
                    opposingReverseOccurred: record.myReverseOccurred,
                    to: &aggregates
                )
            }
        }

        return aggregates.map { key, value in
            MatchupSummary(
                id: key.id,
                opponentBlade: key.bladeDescription,
                opponentBit: key.bit,
                wins: value.wins,
                losses: value.losses,
                draws: value.draws,
                winPoints: value.winPoints,
                lossPoints: value.lossPoints,
                winFinishes: value.winFinishes,
                lossFinishes: value.lossFinishes,
                reverseOccurrences: value.reverseOccurrences,
                opponentReverseOccurrences: value.opponentReverseOccurrences
            )
        }
        .sorted {
            if $0.battleCount != $1.battleCount {
                return $0.battleCount > $1.battleCount
            }
            return $0.opponentDisplayName.compare(
                $1.opponentDisplayName,
                options: [.caseInsensitive, .numeric],
                locale: Locale(identifier: "ja_JP")
            ) == .orderedAscending
        }
    }

    private static func matches(
        _ recordedBey: BeyConfiguration,
        selectedBey: BeyConfiguration
    ) -> Bool {
        guard recordedBey.hasSameBladeForAnalysis(as: selectedBey) else {
            return false
        }
        return selectedBey.bit.isEmpty || recordedBey.bit == selectedBey.bit
    }

    private static func result(
        for winner: MatchWinner,
        searchedSide: RecordedSide
    ) -> SearchedResult {
        switch winner {
        case .draw:
            return .draw
        case .me:
            return searchedSide == .me ? .win : .loss
        case .opponent:
            return searchedSide == .opponent ? .win : .loss
        }
    }

    private static func add(
        opposingBey: BeyConfiguration,
        result: SearchedResult,
        finish: FinishType,
        reverseOccurred: Bool,
        opposingReverseOccurred: Bool,
        to aggregates: inout [OpponentKey: Aggregate]
    ) {
        let key = OpponentKey(bey: opposingBey)
        var aggregate = aggregates[key, default: Aggregate()]

        if reverseOccurred {
            aggregate.reverseOccurrences += 1
        }
        if opposingReverseOccurred {
            aggregate.opponentReverseOccurrences += 1
        }

        switch result {
        case .win:
            aggregate.addWin(finish: finish)
        case .loss:
            aggregate.addLoss(finish: finish)
        case .draw:
            aggregate.draws += 1
        }
        aggregates[key] = aggregate
    }
}

private enum RecordedSide {
    case me
    case opponent
}

private enum SearchedResult {
    case win
    case loss
    case draw
}

private struct OpponentKey: Hashable {
    let system: BladeSystem
    let blade: String
    let lockChip: String
    let mainBlade: String
    let overBlade: String
    let metalBlade: String
    let assistBlade: String
    let bit: String

    init(bey: BeyConfiguration) {
        system = bey.system
        blade = bey.blade
        lockChip = bey.system == .standard ? "" : bey.analysisLockChip
        mainBlade = bey.mainBlade
        overBlade = bey.overBlade
        metalBlade = bey.metalBlade
        assistBlade = bey.assistBlade
        bit = bey.bit
    }

    var bladeDescription: String {
        BeyConfiguration(
            system: system,
            blade: blade,
            lockChip: lockChip,
            mainBlade: mainBlade,
            overBlade: overBlade,
            metalBlade: metalBlade,
            assistBlade: assistBlade
        ).bladeDescription
    }

    var id: String {
        [
            system.rawValue, blade, lockChip, mainBlade,
            overBlade, metalBlade, assistBlade, bit
        ].joined(separator: "\u{1F}")
    }
}

private struct Aggregate {
    var wins = 0
    var losses = 0
    var draws = 0
    var winPoints = 0
    var lossPoints = 0
    var winFinishes: [FinishType: Int] = [:]
    var lossFinishes: [FinishType: Int] = [:]
    var reverseOccurrences = 0
    var opponentReverseOccurrences = 0

    mutating func addWin(finish: FinishType) {
        wins += 1
        winPoints += finish.points
        winFinishes[finish, default: 0] += 1
    }

    mutating func addLoss(finish: FinishType) {
        losses += 1
        lossPoints += finish.points
        lossFinishes[finish, default: 0] += 1
    }
}
