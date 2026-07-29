import SwiftUI

struct BeyConfigurationEditor: View {
    let title: String
    let subtitle: String
    let symbol: String
    let color: Color
    @Binding var configuration: BeyConfiguration

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: symbol)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(color)
                    .frame(width: 38, height: 38)
                    .background(color.opacity(0.14), in: RoundedRectangle(cornerRadius: 11))

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }

            VStack(spacing: 0) {
                HStack {
                    Text("シリーズ")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Picker("シリーズ", selection: $configuration.system) {
                        ForEach(BladeSystem.allCases) { system in
                            Text(system.rawValue).tag(system)
                        }
                    }
                    .labelsHidden()
                }
                .padding(.vertical, 5)

                Text(configuration.system.explanation)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 7)

                Divider()

                switch configuration.system {
                case .standard:
                    PartPickerRow(
                        title: "ブレード",
                        selection: $configuration.blade,
                        options: PartsCatalog.standardBlades
                    )
                case .custom:
                    PartPickerRow(
                        title: "ロックチップ",
                        selection: $configuration.lockChip,
                        options: PartsCatalog.lockChips
                    )
                    Divider()
                    PartPickerRow(
                        title: "メインブレード",
                        selection: $configuration.mainBlade,
                        options: PartsCatalog.mainBlades
                    )
                    Divider()
                    PartPickerRow(
                        title: "アシストブレード",
                        selection: $configuration.assistBlade,
                        options: PartsCatalog.assistBlades
                    )
                case .expand:
                    PartPickerRow(
                        title: "ロックチップ",
                        selection: $configuration.lockChip,
                        options: PartsCatalog.lockChips
                    )
                    Divider()
                    PartPickerRow(
                        title: "オーバーブレード",
                        selection: $configuration.overBlade,
                        options: PartsCatalog.overBlades
                    )
                    Divider()
                    PartPickerRow(
                        title: "メタルブレード",
                        selection: $configuration.metalBlade,
                        options: PartsCatalog.metalBlades
                    )
                    Divider()
                    PartPickerRow(
                        title: "アシストブレード",
                        selection: $configuration.assistBlade,
                        options: PartsCatalog.assistBlades
                    )
                }

                Divider()
                PartPickerRow(
                    title: "ラチェット",
                    selection: $configuration.ratchet,
                    options: PartsCatalog.ratchets
                )
                Divider()
                PartPickerRow(
                    title: "ビット",
                    selection: $configuration.bit,
                    options: PartsCatalog.bits
                )
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.quaternary, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.04), radius: 12, y: 5)
        .onChange(of: configuration.system) { _, newSystem in
            clearHiddenComponents(for: newSystem)
        }
    }

    private func clearHiddenComponents(for system: BladeSystem) {
        switch system {
        case .standard:
            configuration.lockChip = ""
            configuration.mainBlade = ""
            configuration.overBlade = ""
            configuration.metalBlade = ""
            configuration.assistBlade = ""
        case .custom:
            configuration.blade = ""
            configuration.overBlade = ""
            configuration.metalBlade = ""
        case .expand:
            configuration.blade = ""
            configuration.mainBlade = ""
        }
    }
}

private struct PartPickerRow: View {
    let title: String
    @Binding var selection: String
    let options: [String]

    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer(minLength: 8)

            Picker(title, selection: $selection) {
                Text("未選択").tag("")
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
