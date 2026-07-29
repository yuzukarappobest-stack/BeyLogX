import SwiftUI

struct RecordBattleView: View {
    @EnvironmentObject private var store: BattleStore

    @State private var myBey = BeyConfiguration()
    @State private var opponentBey = BeyConfiguration()
    @State private var playedAt = Date()
    @State private var winner: MatchWinner = .me
    @State private var finish: FinishType = .spin
    @State private var stadium: StadiumType = .extreme
    @State private var myReverseOccurred = false
    @State private var opponentReverseOccurred = false
    @State private var note = ""
    @State private var showSaved = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    intro

                    BeyConfigurationEditor(
                        title: "自分のベイ",
                        subtitle: "MY BEY",
                        symbol: "person.fill",
                        color: .blue,
                        configuration: $myBey
                    )

                    versus

                    BeyConfigurationEditor(
                        title: "相手のベイ",
                        subtitle: "OPPONENT",
                        symbol: "person.fill.questionmark",
                        color: .pink,
                        configuration: $opponentBey
                    )

                    resultCard

                    saveButton
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("対戦を記録")
            .navigationBarTitleDisplayMode(.large)
            .overlay(alignment: .top) {
                if showSaved {
                    savedBanner
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.horizontal)
                }
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
        }
    }

    private var intro: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "bolt.horizontal.circle.fill")
                .font(.title2)
                .foregroundStyle(Color("AccentColor"))
            VStack(alignment: .leading, spacing: 4) {
                Text("パーツは空欄でも記録できます")
                    .font(.subheadline.weight(.semibold))
                Text("シリーズを選ぶと、ブレード構成が切り替わります。")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var versus: some View {
        HStack(spacing: 12) {
            Capsule().fill(.quaternary).frame(height: 1)
            Text("VS")
                .font(.caption.weight(.black))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 4)
            Capsule().fill(.quaternary).frame(height: 1)
        }
        .padding(.horizontal, 24)
    }

    private var resultCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Label("対戦結果", systemImage: "flag.checkered")
                .font(.headline)

            DatePicker(
                "対戦日時",
                selection: $playedAt,
                displayedComponents: [.date, .hourAndMinute]
            )
            .font(.subheadline)

            VStack(alignment: .leading, spacing: 8) {
                Text("スタジアム")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Picker("スタジアム", selection: $stadium) {
                    ForEach(StadiumType.allCases) { type in
                        Text(type.shortLabel).tag(type)
                    }
                }
                .pickerStyle(.segmented)
            }

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("勝敗")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 8) {
                    ForEach(MatchWinner.allCases) { choice in
                        Button {
                            winner = choice
                        } label: {
                            Label(choice.shortLabel, systemImage: choice.symbol)
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 11)
                                .foregroundStyle(winner == choice ? .white : .primary)
                                .background(
                                    winner == choice ? winnerColor(choice) : Color(uiColor: .secondarySystemGroupedBackground),
                                    in: RoundedRectangle(cornerRadius: 12)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("決まり手")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Picker("決まり手", selection: $finish) {
                    ForEach(FinishType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .frame(height: 46)
                .background(
                    Color(uiColor: .secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("リバース発生")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                ReverseEventPicker(
                    title: "自分のベイ",
                    occurred: $myReverseOccurred
                )

                ReverseEventPicker(
                    title: "相手のベイ",
                    occurred: $opponentReverseOccurred
                )

                Text("オーバー／エクストリームゾーンへ入り、スタジアムへ戻った場合に「有」を選択")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("メモ（任意）")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                TextField("シュート位置や気づいたこと", text: $note, axis: .vertical)
                    .lineLimit(2...4)
                    .padding(12)
                    .background(
                        Color(uiColor: .secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.quaternary, lineWidth: 1)
        }
    }

    private var saveButton: some View {
        Button(action: saveRecord) {
            Label("この対戦を保存", systemImage: "tray.and.arrow.down.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(.white)
                .background(Color("AccentColor"), in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .accessibilityHint("入力した対戦結果を端末内に保存します")
    }

    private var savedBanner: some View {
        Label("対戦結果を保存しました", systemImage: "checkmark.circle.fill")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.green, in: Capsule())
            .shadow(color: .black.opacity(0.16), radius: 8, y: 4)
    }

    private func saveRecord() {
        let record = BattleRecord(
            playedAt: playedAt,
            myBey: myBey,
            opponentBey: opponentBey,
            winner: winner,
            finish: finish,
            stadium: stadium,
            myReverseOccurred: myReverseOccurred,
            opponentReverseOccurred: opponentReverseOccurred,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        store.add(record)
        note = ""
        playedAt = Date()
        myReverseOccurred = false
        opponentReverseOccurred = false

        withAnimation(.spring(response: 0.35)) {
            showSaved = true
        }
        Task {
            try? await Task.sleep(for: .seconds(1.8))
            withAnimation {
                showSaved = false
            }
        }
    }

    private func winnerColor(_ value: MatchWinner) -> Color {
        switch value {
        case .me: .green
        case .opponent: .red
        case .draw: .gray
        }
    }
}

private struct ReverseEventPicker: View {
    let title: String
    @Binding var occurred: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Picker("\(title)のリバース", selection: $occurred) {
                Text("無").tag(false)
                Text("有").tag(true)
            }
            .pickerStyle(.segmented)
            .frame(width: 120)
        }
        .padding(.horizontal, 12)
        .frame(height: 46)
        .background(
            Color(uiColor: .secondarySystemGroupedBackground),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}
