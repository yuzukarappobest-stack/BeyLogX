const SYSTEM = {
  standard: "BX / UX",
  custom: "CX",
  expand: "CXエクスパンド"
};

const CATALOG = {
  analysisLockChips: ["エンペラー", "ワルキューレ", "プラチップ"],
  standardBlades: [
    "ドランソード", "ヘルズサイズ", "ウィザードアロー", "ナイトシールド",
    "コバルトドレイク", "ナイトランス", "シャークエッジ", "レオンクロー",
    "ヴァイパーテイル", "ライノホーン", "ドランダガー", "ヘルズチェイン",
    "フェニックスフェザー", "フェニックスウイング", "ワイバーンゲイル",
    "ユニコーンスティング", "スフィンクスカウル", "ティラノビート",
    "ヴァイスタイガー", "ブラックシェル", "ホエールウェーブ", "ベアスクラッチ",
    "クリムゾンガルーダ", "プテラスイング", "シノビナイフ", "マンモスタスク",
    "クロコクランチ", "シェルタードレイク", "トリケラプレス", "サムライスチール",
    "トリケラスパイキー", "ティラノロア", "サムライカリバー", "ゴートタックル",
    "シャークギル", "コバルトドラグーン", "ドランストライク", "ヘブンズリング",
    "ドランバスター", "ヘルズハンマー", "ヘルズネザー（ノーマル）", "ヘルズネザー（ロー）", "ウィザードロッド", "シノビシャドウ",
    "エアロペガサス", "レオンクレスト", "フェニックスラダー", "シルバーウルフ",
    "サムライセイバー", "ナイトメイル", "インパクトドレイク", "ゴーストサークル",
    "ゴーレムロック", "スコーピオスピア", "シャークスケイル", "ワイバーンホバー",
    "マミーカース", "オロチクラスタ", "クロックミラージュ", "メテオドラグーン",
    "バレットグリフォン", "グローリーワルキューレ",
    "ドランザースパイラル", "ドライガースラッシュ", "ドラシエルシールド",
    "ドラグーンストーム", "ライトニングエルドラゴ（ア）", "ライトニングエルドラゴ（連）",
    "ストームペガシス", "ロックレオーネ", "ビクトリーヴァルキリー",
    "ゼノエクスカリバー", "ストームスプリガン", "アイアンマン", "サノス",
    "スパイダーマン", "ヴェノム", "ルーク・スカイウォーカー", "ダース・ベイダー",
    "マンダロリアン", "モフ・ギデオン", "オプティマスプライム", "メガトロン",
    "オプティマスプライマル", "スタースクリーム"
  ],
  lockChips: [
    "ドラン", "ウィザード", "ペルセウス", "ヘルズ", "ライノ", "フォックス",
    "ペガサス", "ケルベロス", "ホエール", "ソル", "ウルフ", "フェニックス",
    "バハムート", "ナイト", "ラグナ", "ユニコーン",
    "ワルキューレ（メタル）", "エンペラー（メタル）"
  ],
  mainBlades: [
    "ブレイブ", "アーク", "ダーク", "リーパー", "ブラッシュ", "ブラスト",
    "フレイム", "ボルト", "ハント", "マイト", "フレア", "エクリプス"
  ],
  overBlades: ["B（ブレイク）", "G（ガード）", "F（フロー）", "P（ピーク）", "O（アウター）"],
  metalBlades: ["ブリッツ", "フォートレス", "レイジ", "デルタ", "ウイップ"],
  assistBlades: [
    "S（スラッシュ）", "J（ジャギー）", "H（ヘビー）", "K（ナックル）",
    "O（オッド）", "R（ラウンド）", "B（バンパー）", "C（チャージ）",
    "A（アサルト）", "M（マッシブ）", "F（フリー）", "V（ヴァーチカル）",
    "T（ターン）", "D（デュアル）", "E（イレイズ）", "W（ウィール）",
    "Z（ジリオン）"
  ],
  ratchets: [
    "0-60", "0-70", "0-80", "1-50", "1-60", "1-70", "1-80",
    "2-60", "2-70", "2-80", "3-60", "3-70", "3-80",
    "4-50", "4-60", "4-70", "4-80", "5-60", "5-70", "5-80",
    "6-60", "6-70", "6-80", "7-60", "7-70", "7-80", "8-70", "8-80",
    "9-60", "9-70", "9-80", "4-55", "7-55", "9-65", "3-85", "M-85",
    "Tr（ターボ・一体型）", "Op（オペレート・一体型）"
  ],
  bits: [
    "F（フラット）", "LF（ローフラット）", "R（ラッシュ）", "GF（ギヤフラット）",
    "A（アクセル）", "Q（クエイク）", "C（サイクロン）", "L（レベル）",
    "RA（ラバーアクセル）", "LR（ローラッシュ）", "V（ボルテックス）",
    "GR（ギアラッシュ）", "UF（アンダーフラット）", "J（ジョルト）",
    "I（イグニッション）", "FF（フリーフラット）", "Tr（ターボ・一体型）",
    "T（テーパー）", "P（ポイント）", "HT（ハイテーパー）", "GP（ギヤポイント）",
    "H（ヘキサ）", "U（ユナイト）", "E（エレベート）", "TP（トランスポイント）",
    "K（キック）", "Z（ザップ）", "M（マージ）", "TK（トランスキック）",
    "GU（ギヤユナイト）", "Op（オペレート・一体型）",
    "B（ボール）", "O（オーブ）", "GB（ギヤボール）", "DB（ディスクボール）",
    "G（グライド）", "FB（フリーボール）", "LO（ローオーブ）",
    "WB（ウォールボール）", "Y（イールディング）", "Nr（ナロー）",
    "N（ニードル）", "HN（ハイニードル）", "S（スパイク）", "GN（ギヤニードル）",
    "MN（メタルニードル）", "D（ドット）", "BS（バウンドスパイク）",
    "UN（アンダーニードル）", "W（ウェッジ）", "WW（ウォールウェッジ）",
    "DS（ディスクスパイク）"
  ]
};

const FINISHES = [
  "スピンフィニッシュ",
  "オーバーフィニッシュ",
  "バーストフィニッシュ",
  "エクストリームフィニッシュ",
  "その他"
];

const FINISH_SHORT = {
  "スピンフィニッシュ": "スピン",
  "オーバーフィニッシュ": "オーバー",
  "バーストフィニッシュ": "バースト",
  "エクストリームフィニッシュ": "エクストリーム",
  "その他": "その他"
};

const FINISH_POINTS = {
  "スピンフィニッシュ": 1,
  "オーバーフィニッシュ": 2,
  "バーストフィニッシュ": 2,
  "エクストリームフィニッシュ": 3,
  "その他": 0
};

const collator = new Intl.Collator("ja-JP", { numeric: true, sensitivity: "base" });
const sorted = values => [...values].sort(collator.compare);

const emptyBey = () => ({
  system: SYSTEM.standard,
  blade: "",
  lockChip: "",
  mainBlade: "",
  overBlade: "",
  metalBlade: "",
  assistBlade: "",
  ratchet: "",
  bit: ""
});

function normalizeBey(bey = {}) {
  const normalized = { ...emptyBey(), ...bey };
  // 分割前に保存されたデータは従来形状の「ノーマル」として引き継ぐ。
  if (normalized.blade === "ヘルズネザー") {
    normalized.blade = "ヘルズネザー（ノーマル）";
  }
  return normalized;
}

const states = {
  my: emptyBey(),
  opponent: emptyBey(),
  analysis: emptyBey()
};

let records = [];
let favorites = [];
let db;
let deleteCandidateID = null;
let toastTimer;

const $ = selector => document.querySelector(selector);
const $$ = selector => [...document.querySelectorAll(selector)];

class BattleDatabase {
  static open() {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open("BeyLogX", 2);
      request.onupgradeneeded = () => {
        const database = request.result;
        if (!database.objectStoreNames.contains("battles")) {
          const store = database.createObjectStore("battles", { keyPath: "id" });
          store.createIndex("playedAt", "playedAt");
        }
        if (!database.objectStoreNames.contains("favoriteBeys")) {
          database.createObjectStore("favoriteBeys", { keyPath: "id" });
        }
      };
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  static transact(storeName, mode, operation) {
    return new Promise((resolve, reject) => {
      const transaction = db.transaction(storeName, mode);
      const store = transaction.objectStore(storeName);
      const request = operation(store);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
      transaction.onerror = () => reject(transaction.error);
    });
  }

  static all() { return this.transact("battles", "readonly", store => store.getAll()); }
  static put(record) { return this.transact("battles", "readwrite", store => store.put(record)); }
  static remove(id) { return this.transact("battles", "readwrite", store => store.delete(id)); }
  static allFavorites() { return this.transact("favoriteBeys", "readonly", store => store.getAll()); }
  static putFavorite(favorite) { return this.transact("favoriteBeys", "readwrite", store => store.put(favorite)); }
  static removeFavorite(id) { return this.transact("favoriteBeys", "readwrite", store => store.delete(id)); }
}

function makeSelect(label, key, options, state, blankLabel = "未選択") {
  const wrapper = document.createElement("label");
  wrapper.className = "field";
  const caption = document.createElement("span");
  caption.textContent = label;
  const select = document.createElement("select");
  select.dataset.key = key;

  const blank = document.createElement("option");
  blank.value = "";
  blank.textContent = blankLabel;
  select.append(blank);

  for (const value of sorted(options)) {
    const option = document.createElement("option");
    option.value = value;
    option.textContent = value;
    select.append(option);
  }
  select.value = state[key] ?? "";
  select.addEventListener("change", () => {
    state[key] = select.value;
    if (state === states.analysis) renderAnalysis();
  });

  wrapper.append(caption, select);
  return wrapper;
}

function renderConfiguration(containerID, state, { analysis = false } = {}) {
  const container = document.getElementById(containerID);
  container.replaceChildren();

  const systemField = makeSelect(
    "シリーズ",
    "system",
    Object.values(SYSTEM),
    state,
    "シリーズを選択"
  );
  systemField.querySelector("select").addEventListener("change", () => {
    clearHiddenComponents(state);
    renderConfiguration(containerID, state, { analysis });
    if (analysis) renderAnalysis();
  });
  container.append(systemField);

  const note = document.createElement("p");
  note.className = "system-note";
  note.textContent = {
    [SYSTEM.standard]: "ブレードを1つ選択",
    [SYSTEM.custom]: "ロックチップ＋メイン＋アシスト",
    [SYSTEM.expand]: "ロックチップ＋オーバー＋メタル＋アシスト"
  }[state.system] ?? "";
  container.append(note);

  if (state.system === SYSTEM.standard) {
    container.append(makeSelect("ブレード", "blade", CATALOG.standardBlades, state));
  } else if (state.system === SYSTEM.custom) {
    container.append(
      makeSelect("ロックチップ", "lockChip", analysis ? CATALOG.analysisLockChips : CATALOG.lockChips, state),
      makeSelect("メインブレード", "mainBlade", CATALOG.mainBlades, state),
      makeSelect("アシストブレード", "assistBlade", CATALOG.assistBlades, state)
    );
  } else if (state.system === SYSTEM.expand) {
    container.append(
      makeSelect("ロックチップ", "lockChip", analysis ? CATALOG.analysisLockChips : CATALOG.lockChips, state),
      makeSelect("オーバーブレード", "overBlade", CATALOG.overBlades, state),
      makeSelect("メタルブレード", "metalBlade", CATALOG.metalBlades, state),
      makeSelect("アシストブレード", "assistBlade", CATALOG.assistBlades, state)
    );
  }

  container.append(
    makeSelect("ラチェット", "ratchet", CATALOG.ratchets, state, analysis ? "指定しない" : "未選択"),
    makeSelect("ビット", "bit", CATALOG.bits, state, analysis ? "指定しない" : "未選択")
  );
}

function clearHiddenComponents(state) {
  if (state.system === SYSTEM.standard) {
    Object.assign(state, {
      lockChip: "", mainBlade: "", overBlade: "", metalBlade: "", assistBlade: ""
    });
  } else if (state.system === SYSTEM.custom) {
    Object.assign(state, { blade: "", overBlade: "", metalBlade: "" });
  } else {
    Object.assign(state, { blade: "", mainBlade: "" });
  }
}

function normalizeFavorite(value) {
  return {
    id: String(value.id),
    name: String(value.name || "名称未設定"),
    bey: normalizeBey(value.bey),
    updatedAt: String(value.updatedAt || "")
  };
}

function renderFavoriteControls(selectedID = $("#favorite-select")?.value || "") {
  const select = $("#favorite-select");
  if (!select) return;
  const sortedFavorites = [...favorites].sort((a, b) => collator.compare(a.name, b.name));
  select.replaceChildren(new Option(sortedFavorites.length ? "選択してください" : "登録なし", ""));
  for (const favorite of sortedFavorites) {
    select.append(new Option(favorite.name, favorite.id));
  }
  select.value = favorites.some(favorite => favorite.id === selectedID) ? selectedID : "";
  const disabled = !select.value;
  $("#favorite-apply-my").disabled = disabled;
  $("#favorite-apply-opponent").disabled = disabled;
  $("#favorite-delete").disabled = disabled;
}

async function saveFavorite(source) {
  const state = states[source];
  const input = $("#favorite-name");
  const name = input.value.trim() || displayName(state);
  const existing = favorites.find(favorite => favorite.name === name);
  const favorite = {
    id: existing?.id || crypto.randomUUID(),
    name,
    bey: { ...emptyBey(), ...state },
    updatedAt: new Date().toISOString()
  };

  try {
    await BattleDatabase.putFavorite(favorite);
    favorites = existing
      ? favorites.map(item => item.id === favorite.id ? favorite : item)
      : [...favorites, favorite];
    input.value = name;
    renderFavoriteControls(favorite.id);
    showToast(existing ? "よく使うベイを更新しました" : "よく使うベイに登録しました");
  } catch (error) {
    console.error(error);
    showToast("よく使うベイを保存できませんでした");
  }
}

function applyFavorite(target) {
  const favorite = favorites.find(item => item.id === $("#favorite-select").value);
  if (!favorite) return;
  Object.assign(states[target], emptyBey(), favorite.bey);
  renderConfiguration(target === "my" ? "my-config" : "opponent-config", states[target]);
  showToast(`${favorite.name}を${target === "my" ? "自分" : "相手"}へ呼び出しました`);
}

async function deleteFavorite() {
  const id = $("#favorite-select").value;
  const favorite = favorites.find(item => item.id === id);
  if (!favorite) return;
  try {
    await BattleDatabase.removeFavorite(id);
    favorites = favorites.filter(item => item.id !== id);
    renderFavoriteControls();
    showToast(`${favorite.name}を削除しました`);
  } catch (error) {
    console.error(error);
    showToast("よく使うベイを削除できませんでした");
  }
}

function swapBattleSides() {
  const previousMyBey = { ...states.my };
  Object.assign(states.my, states.opponent);
  Object.assign(states.opponent, previousMyBey);

  renderConfiguration("my-config", states.my);
  renderConfiguration("opponent-config", states.opponent);

  const winner = $('input[name="winner"]:checked').value;
  const swappedWinner = winner === "自分の勝ち"
    ? "相手の勝ち"
    : winner === "相手の勝ち"
      ? "自分の勝ち"
      : winner;
  $(`input[name="winner"][value="${swappedWinner}"]`).checked = true;

  const myReverse = $("#my-reverse").value;
  $("#my-reverse").value = $("#opponent-reverse").value;
  $("#opponent-reverse").value = myReverse;

  const mySelfDestruct = $("#my-self-destruct").value;
  $("#my-self-destruct").value = $("#opponent-self-destruct").value;
  $("#opponent-self-destruct").value = mySelfDestruct;

  showToast("自分と相手を入れ替えました");
}

function setInitialDate() {
  const now = new Date();
  const local = new Date(now.getTime() - now.getTimezoneOffset() * 60_000);
  $("#played-at").value = local.toISOString().slice(0, 16);
}

function isoWithoutMilliseconds(date) {
  return date.toISOString().replace(/\.\d{3}Z$/, "Z");
}

async function saveBattle(event) {
  event.preventDefault();
  const date = new Date($("#played-at").value);
  if (Number.isNaN(date.getTime())) {
    showToast("対戦日時を確認してください");
    return;
  }

  const record = {
    id: crypto.randomUUID(),
    playedAt: isoWithoutMilliseconds(date),
    myBey: { ...states.my },
    opponentBey: { ...states.opponent },
    winner: $('input[name="winner"]:checked').value,
    finish: $("#finish").value,
    stadium: $("#stadium").value,
    myReverseOccurred: $("#my-reverse").value === "true",
    opponentReverseOccurred: $("#opponent-reverse").value === "true",
    mySelfDestructOccurred: $("#my-self-destruct").value === "true",
    opponentSelfDestructOccurred: $("#opponent-self-destruct").value === "true",
    note: $("#note").value.trim()
  };

  try {
    await BattleDatabase.put(record);
    records.unshift(record);
    $("#note").value = "";
    $("#my-reverse").value = "false";
    $("#opponent-reverse").value = "false";
    $("#my-self-destruct").value = "false";
    $("#opponent-self-destruct").value = "false";
    setInitialDate();
    renderAllDataViews();
    showToast("対戦結果を保存しました");
  } catch (error) {
    console.error(error);
    showToast("保存できませんでした");
  }
}

function displayName(bey) {
  const lower = [bey.ratchet, bey.bit].filter(Boolean).join("・");
  const blade = bladeDescription(bey);
  return lower ? `${blade}  ${lower}` : blade;
}

function bladeDescription(bey, normalize = false) {
  let parts;
  if (bey.system === SYSTEM.standard) {
    parts = [bey.blade];
  } else if (bey.system === SYSTEM.custom) {
    parts = [normalize ? analysisLockChip(bey.lockChip) : bey.lockChip, bey.mainBlade, bey.assistBlade];
  } else {
    parts = [
      normalize ? analysisLockChip(bey.lockChip) : bey.lockChip,
      bey.overBlade,
      bey.metalBlade,
      bey.assistBlade
    ];
  }
  return parts.filter(Boolean).join(" / ") || "ブレード未選択";
}

function formatDate(value) {
  const date = new Date(value);
  return Number.isNaN(date.getTime())
    ? value
    : new Intl.DateTimeFormat("ja-JP", {
        year: "numeric", month: "numeric", day: "numeric", hour: "2-digit", minute: "2-digit"
      }).format(date);
}

function escapeHTML(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function renderHistory() {
  const wins = records.filter(record => record.winner === "自分の勝ち").length;
  const losses = records.filter(record => record.winner === "相手の勝ち").length;
  const draws = records.length - wins - losses;
  $("#history-summary").innerHTML = `
    <div class="summary-tile"><strong>${records.length}</strong><span>対戦</span></div>
    <div class="summary-tile win"><strong>${wins}</strong><span>自分の勝ち</span></div>
    <div class="summary-tile loss"><strong>${losses}</strong><span>自分の負け</span></div>
    <div class="summary-tile"><strong>${draws}</strong><span>引き分け</span></div>
  `;

  const list = $("#history-list");
  if (records.length === 0) {
    list.innerHTML = `<div class="empty-state"><strong>対戦記録がありません</strong>「記録する」から最初の対戦を保存しましょう。</div>`;
    return;
  }

  list.innerHTML = records.map(record => {
    const type = record.winner === "自分の勝ち" ? "win" : record.winner === "相手の勝ち" ? "loss" : "draw";
    const label = type === "win" ? "勝" : type === "loss" ? "負" : "分";
    const events = [
      record.myReverseOccurred ? "自分リバース" : "",
      record.opponentReverseOccurred ? "相手リバース" : "",
      record.mySelfDestructOccurred ? "自分自滅" : "",
      record.opponentSelfDestructOccurred ? "相手自滅" : ""
    ].filter(Boolean);
    const eventText = events.length ? `・${events.join("・")}` : "";
    return `
      <article class="history-item ${type}">
        <div class="result-orb">${label}</div>
        <div class="history-main">
          <strong>${escapeHTML(displayName(record.myBey))}</strong>
          <span>vs ${escapeHTML(displayName(record.opponentBey))}</span>
          <span class="history-meta">${escapeHTML(record.finish)}・${escapeHTML(record.stadium)}${escapeHTML(eventText)}・${escapeHTML(formatDate(record.playedAt))}</span>
        </div>
        <button class="delete-button" type="button" data-delete-id="${escapeHTML(record.id)}" aria-label="この対戦を削除">削除</button>
      </article>
    `;
  }).join("");
}

function hasBladeSelection(bey) {
  if (bey.system === SYSTEM.standard) return Boolean(bey.blade);
  if (bey.system === SYSTEM.custom) return Boolean(bey.lockChip || bey.mainBlade || bey.assistBlade);
  return Boolean(bey.lockChip || bey.overBlade || bey.metalBlade || bey.assistBlade);
}

function analysisLockChip(value = "") {
  if (!value) return "";
  if (value.includes("エンペラー")) return "エンペラー";
  if (value.includes("ワルキューレ")) return "ワルキューレ";
  return "プラチップ";
}

function sameBladeForAnalysis(recorded, selected) {
  if (recorded.system !== selected.system) return false;
  if (selected.system === SYSTEM.standard) return recorded.blade === selected.blade;
  if (selected.system === SYSTEM.custom) {
    return analysisLockChip(recorded.lockChip) === analysisLockChip(selected.lockChip)
      && recorded.mainBlade === selected.mainBlade
      && recorded.assistBlade === selected.assistBlade;
  }
  return analysisLockChip(recorded.lockChip) === analysisLockChip(selected.lockChip)
    && recorded.overBlade === selected.overBlade
    && recorded.metalBlade === selected.metalBlade
    && recorded.assistBlade === selected.assistBlade;
}

function matchesSelected(recorded, selected) {
  return sameBladeForAnalysis(recorded, selected)
    && (!selected.ratchet || recorded.ratchet === selected.ratchet)
    && (!selected.bit || recorded.bit === selected.bit);
}

function opponentKey(bey) {
  const normalized = {
    system: bey.system,
    blade: bey.blade || "",
    lockChip: bey.system === SYSTEM.standard ? "" : analysisLockChip(bey.lockChip),
    mainBlade: bey.mainBlade || "",
    overBlade: bey.overBlade || "",
    metalBlade: bey.metalBlade || "",
    assistBlade: bey.assistBlade || "",
    ratchet: bey.ratchet || "",
    bit: bey.bit || ""
  };
  return JSON.stringify(normalized);
}

function emptyAggregate(opposingBey) {
  return {
    opponentBlade: bladeDescription(opposingBey, true),
    opponentRatchet: opposingBey.ratchet || "",
    opponentBit: opposingBey.bit || "",
    wins: 0,
    losses: 0,
    draws: 0,
    winPoints: 0,
    lossPoints: 0,
    winFinishes: {},
    lossFinishes: {},
    reverseOccurrences: 0,
    opponentReverseOccurrences: 0
  };
}

function addAnalysisEntry(
  map,
  opposingBey,
  result,
  record,
  reverseOccurred,
  opposingReverseOccurred
) {
  const key = opponentKey(opposingBey);
  const aggregate = map.get(key) ?? emptyAggregate(opposingBey);
  if (reverseOccurred) aggregate.reverseOccurrences += 1;
  if (opposingReverseOccurred) aggregate.opponentReverseOccurrences += 1;

  if (result === "win") {
    aggregate.wins += 1;
    aggregate.winPoints += FINISH_POINTS[record.finish] ?? 0;
    aggregate.winFinishes[record.finish] = (aggregate.winFinishes[record.finish] ?? 0) + 1;
  } else if (result === "loss") {
    aggregate.losses += 1;
    aggregate.lossPoints += FINISH_POINTS[record.finish] ?? 0;
    aggregate.lossFinishes[record.finish] = (aggregate.lossFinishes[record.finish] ?? 0) + 1;
  } else {
    aggregate.draws += 1;
  }
  map.set(key, aggregate);
}

function analyze(selected) {
  if (!hasBladeSelection(selected)) return [];
  const map = new Map();

  for (const record of records) {
    if (matchesSelected(record.myBey, selected)) {
      const result = record.winner === "引き分け" ? "draw" : record.winner === "自分の勝ち" ? "win" : "loss";
      addAnalysisEntry(
        map, record.opponentBey, result, record,
        record.myReverseOccurred, record.opponentReverseOccurred
      );
    }
    if (matchesSelected(record.opponentBey, selected)) {
      const result = record.winner === "引き分け" ? "draw" : record.winner === "相手の勝ち" ? "win" : "loss";
      addAnalysisEntry(
        map, record.myBey, result, record,
        record.opponentReverseOccurred, record.myReverseOccurred
      );
    }
  }

  return [...map.values()].sort((a, b) => {
    const countDifference = battleCount(b) - battleCount(a);
    return countDifference || collator.compare(
      `${a.opponentBlade} ${a.opponentRatchet} ${a.opponentBit}`,
      `${b.opponentBlade} ${b.opponentRatchet} ${b.opponentBit}`
    );
  });
}

const battleCount = summary => summary.wins + summary.losses + summary.draws;
const percentage = value => new Intl.NumberFormat("ja-JP", {
  style: "percent", minimumFractionDigits: 1, maximumFractionDigits: 1
}).format(value);

function finishDescription(finishes) {
  const parts = FINISHES
    .filter(finish => (finishes[finish] ?? 0) > 0)
    .map(finish => `${FINISH_SHORT[finish]} ${finishes[finish]}回`);
  return parts.length ? parts.join("・") : "なし";
}

function selectedBeyName(bey) {
  const blade = bladeDescription(bey, true);
  const lower = [bey.ratchet, bey.bit].filter(Boolean).join("・");
  return lower ? `${blade}・${lower}` : blade;
}

function selfDestructSummary(selected) {
  let appearanceCount = 0;
  let occurrenceCount = 0;

  for (const record of records) {
    if (matchesSelected(record.myBey, selected)) {
      appearanceCount += 1;
      if (record.mySelfDestructOccurred) occurrenceCount += 1;
    }
    if (matchesSelected(record.opponentBey, selected)) {
      appearanceCount += 1;
      if (record.opponentSelfDestructOccurred) occurrenceCount += 1;
    }
  }

  return { appearanceCount, occurrenceCount };
}

function renderSelfDestructSummary() {
  const container = $("#analysis-self-destruct");
  if (!hasBladeSelection(states.analysis) || !states.analysis.bit) {
    container.hidden = true;
    container.replaceChildren();
    return;
  }

  const summary = selfDestructSummary(states.analysis);
  const rate = summary.appearanceCount ? percentage(summary.occurrenceCount / summary.appearanceCount) : "—";
  const selectedName = selectedBeyName(states.analysis);
  container.hidden = false;
  container.innerHTML = `
    <div>
      <span class="self-destruct-label">選択カスタムの自滅傾向</span>
      <strong>${escapeHTML(selectedName)}</strong>
      <small>未指定のパーツはすべてまとめて集計</small>
    </div>
    <div class="self-destruct-metric">
      <strong>${rate}</strong>
      <span>自滅率</span>
      <small>${summary.occurrenceCount}回 / ${summary.appearanceCount}戦</small>
    </div>
  `;
}

function matchupJudgement(winRate, expectedPoints) {
  if (winRate > 0.5 && expectedPoints > 0) return { label: "有利", className: "favorable" };
  if (winRate < 0.5 && expectedPoints < 0) return { label: "不利", className: "unfavorable" };
  if (winRate === 0.5 && expectedPoints === 0) return { label: "互角", className: "even" };
  return { label: "傾向混在", className: "mixed" };
}

function renderAdvantage() {
  const selection = $("#advantage-selection");
  const container = $("#advantage-results");
  if (!hasBladeSelection(states.analysis) || !states.analysis.bit) {
    selection.innerHTML = "";
    container.innerHTML = `<div class="empty-state"><strong>ブレードとビットを選択してください</strong>結果検索へ戻り、判定したいカスタムを選んでください。</div>`;
    return;
  }

  selection.innerHTML = `
    <span>判定するカスタム</span>
    <strong>${escapeHTML(selectedBeyName(states.analysis))}</strong>
  `;

  const eligible = analyze(states.analysis)
    .map(summary => {
      const count = battleCount(summary);
      const decided = summary.wins + summary.losses;
      const winRate = decided ? summary.wins / decided : 0;
      const expectedPoints = (summary.winPoints - summary.lossPoints) / count;
      return { ...summary, count, winRate, expectedPoints, judgement: matchupJudgement(winRate, expectedPoints) };
    })
    .filter(summary => summary.count >= 10);

  const sortKey = $("#advantage-sort").value;
  eligible.sort((a, b) => {
    const pointsFirst = sortKey.startsWith("expectedPoints");
    const ascending = sortKey.endsWith("Low");
    const primary = pointsFirst
      ? a.expectedPoints - b.expectedPoints
      : a.winRate - b.winRate;
    const secondary = pointsFirst
      ? a.winRate - b.winRate
      : a.expectedPoints - b.expectedPoints;
    const direction = ascending ? 1 : -1;
    return direction * (primary || secondary) || collator.compare(
      `${a.opponentBlade} ${a.opponentRatchet} ${a.opponentBit}`,
      `${b.opponentBlade} ${b.opponentRatchet} ${b.opponentBit}`
    );
  });

  if (eligible.length === 0) {
    container.innerHTML = `<div class="empty-state"><strong>10戦以上の相手構成がありません</strong>同じブレード＋ビットの相手と10戦以上対戦すると判定されます。</div>`;
    return;
  }

  container.innerHTML = eligible.map((summary, index) => `
    <article class="card advantage-row">
      <span class="ranking-number">${index + 1}</span>
      <div class="advantage-opponent">
        <span>対戦相手</span>
        <strong>${escapeHTML(summary.opponentBlade)}</strong>
        <small>${escapeHTML(summary.opponentRatchet || "ラチェット未選択")}・${escapeHTML(summary.opponentBit || "ビット未選択")}・${summary.wins}勝 ${summary.losses}敗${summary.draws ? ` ${summary.draws}分` : ""}（${summary.count}戦）</small>
      </div>
      <span class="judgement-badge ${summary.judgement.className}">${summary.judgement.label}</span>
      <div class="advantage-value win-rate">
        <strong>${percentage(summary.winRate)}</strong>
        <span>勝率</span>
      </div>
      <div class="advantage-value expected">
        <strong>${summary.expectedPoints > 0 ? "+" : ""}${summary.expectedPoints.toFixed(2)}</strong>
        <span>ポイント期待値 / 戦</span>
      </div>
    </article>
  `).join("");
}

function renderAnalysis() {
  const heading = $("#analysis-heading");
  const container = $("#analysis-results");
  $("#open-advantage").disabled = !hasBladeSelection(states.analysis) || !states.analysis.bit;
  renderSelfDestructSummary();
  if (!hasBladeSelection(states.analysis)) {
    heading.innerHTML = "";
    container.innerHTML = `<div class="empty-state"><strong>ブレードを選択</strong>そのベイがどのベイに勝ったか・負けたかを表示します。</div>`;
    return;
  }

  const summaries = analyze(states.analysis);
  if (summaries.length === 0) {
    heading.innerHTML = "";
    container.innerHTML = `<div class="empty-state"><strong>該当する対戦がありません</strong>ブレードやビットの条件を変えてください。</div>`;
    return;
  }

  const total = summaries.reduce((sum, item) => sum + battleCount(item), 0);
  heading.innerHTML = `
    <h3>選択したベイの対戦成績</h3>
    <p>${total}件の対戦・${summaries.length}種類の相手構成</p>
  `;
  container.innerHTML = summaries.map(summary => {
    const count = battleCount(summary);
    const decided = summary.wins + summary.losses;
    const winRate = decided ? summary.wins / decided : 0;
    const reverseRate = count ? summary.reverseOccurrences / count : 0;
    const opponentReverseRate = count ? summary.opponentReverseOccurrences / count : 0;
    return `
      <article class="card matchup-card">
        <div class="matchup-opponent">
          <h3>${escapeHTML(summary.opponentBlade)}</h3>
          <span class="bit-chip">${escapeHTML(summary.opponentRatchet || "ラチェット未選択")}</span>
          <span class="bit-chip">${escapeHTML(summary.opponentBit || "ビット未選択")}</span>
        </div>
        <div class="metrics">
          <div class="metric"><strong>${summary.wins}勝 ${summary.losses}敗</strong><span>${summary.draws ? `引分 ${summary.draws}` : "勝敗数"}</span></div>
          <div class="metric rate"><strong>${percentage(winRate)}</strong><span>勝率</span></div>
          <div class="metric win"><strong>${summary.winPoints}</strong><span>勝ちポイント合計</span></div>
          <div class="metric loss"><strong>${summary.lossPoints}</strong><span>負けポイント合計</span></div>
        </div>
        <div class="breakdowns">
          <div class="breakdown"><span>勝ち方</span>${escapeHTML(finishDescription(summary.winFinishes))}</div>
          <div class="breakdown"><span>負け方</span>${escapeHTML(finishDescription(summary.lossFinishes))}</div>
        </div>
        <div class="reverse-stats">
          <span>検索したベイのリバース <strong>${summary.reverseOccurrences}回 / ${count}戦（${percentage(reverseRate)}）</strong></span>
          <span>対戦したベイのリバース <strong>${summary.opponentReverseOccurrences}回 / ${count}戦（${percentage(opponentReverseRate)}）</strong></span>
        </div>
      </article>
    `;
  }).join("");
}

function renderAllDataViews() {
  records.sort((a, b) => new Date(b.playedAt) - new Date(a.playedAt));
  renderHistory();
  renderAnalysis();
  $("#data-record-count").textContent = `${records.length}件`;
}

function showView(name) {
  $$(".view").forEach(view => view.classList.toggle("is-active", view.id === `${name}-view`));
  const navigationView = name === "advantage" ? "analysis" : name;
  $$(".bottom-nav button").forEach(button => button.classList.toggle("is-active", button.dataset.view === navigationView));
  if (name === "history") renderHistory();
  if (name === "analysis") renderAnalysis();
  if (name === "advantage") renderAdvantage();
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function showToast(message) {
  const toast = $("#toast");
  toast.textContent = message;
  toast.classList.add("is-visible");
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove("is-visible"), 2400);
}

function normalizedRecord(value) {
  if (!value || typeof value !== "object") throw new Error("対戦記録の形式が不正です");
  if (!value.id || !value.playedAt || !value.myBey || !value.opponentBey || !value.winner || !value.finish) {
    throw new Error("必要な項目がない対戦記録があります");
  }
  return {
    id: String(value.id),
    playedAt: String(value.playedAt),
    myBey: normalizeBey(value.myBey),
    opponentBey: normalizeBey(value.opponentBey),
    winner: String(value.winner),
    finish: String(value.finish),
    stadium: value.stadium || "エクストリームスタジアム",
    myReverseOccurred: Boolean(value.myReverseOccurred ?? value.myBey?.isReversed ?? false),
    opponentReverseOccurred: Boolean(value.opponentReverseOccurred ?? value.opponentBey?.isReversed ?? false),
    mySelfDestructOccurred: Boolean(value.mySelfDestructOccurred ?? false),
    opponentSelfDestructOccurred: Boolean(value.opponentSelfDestructOccurred ?? false),
    note: String(value.note ?? "")
  };
}

async function importJSONFile(file) {
  try {
    const parsed = JSON.parse(await file.text());
    if (!Array.isArray(parsed)) throw new Error("JSONの最上位が配列ではありません");
    const imported = parsed.map(normalizedRecord);
    const existingIDs = new Set(records.map(record => record.id));
    const additions = imported.filter(record => !existingIDs.has(record.id));
    for (const record of additions) await BattleDatabase.put(record);
    records.push(...additions);
    renderAllDataViews();
    showToast(additions.length ? `${additions.length}件を追加しました` : "新しい記録はありませんでした");
  } catch (error) {
    console.error(error);
    showToast(`読み込めませんでした：${error.message}`);
  } finally {
    $("#json-file-input").value = "";
  }
}

function exportRecords() {
  return records.map(record => ({
    ...record,
    playedAt: isoWithoutMilliseconds(new Date(record.playedAt)),
    myBey: { ...emptyBey(), ...record.myBey },
    opponentBey: { ...emptyBey(), ...record.opponentBey }
  }));
}

function download(content, filename, type) {
  const blob = new Blob([content], { type });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = filename;
  document.body.append(link);
  link.click();
  link.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}

function dateStamp() {
  return new Intl.DateTimeFormat("sv-SE", {
    year: "numeric", month: "2-digit", day: "2-digit"
  }).format(new Date()).replaceAll("-", "");
}

function exportJSON() {
  download(
    JSON.stringify(exportRecords(), null, 2),
    `BeyLogX_${dateStamp()}.json`,
    "application/json;charset=utf-8"
  );
  showToast("JSONバックアップを書き出しました");
}

function csvEscape(value) {
  const text = String(value ?? "");
  return /[",\r\n]/.test(text) ? `"${text.replaceAll('"', '""')}"` : text;
}

function exportCSV() {
  const header = [
    "日時", "スタジアム", "勝敗", "決まり手",
    "自分_リバース発生", "相手_リバース発生",
    "自分_自滅発生", "相手_自滅発生",
    "自分_システム", "自分_ブレード", "自分_ロックチップ", "自分_メインブレード",
    "自分_オーバーブレード", "自分_メタルブレード", "自分_アシストブレード",
    "自分_ラチェット", "自分_ビット",
    "相手_システム", "相手_ブレード", "相手_ロックチップ", "相手_メインブレード",
    "相手_オーバーブレード", "相手_メタルブレード", "相手_アシストブレード",
    "相手_ラチェット", "相手_ビット", "メモ"
  ];
  const beyValues = bey => [
    bey.system, bey.blade, bey.lockChip, bey.mainBlade, bey.overBlade,
    bey.metalBlade, bey.assistBlade, bey.ratchet, bey.bit
  ];
  const rows = records.map(record => [
    record.playedAt, record.stadium, record.winner, record.finish,
    record.myReverseOccurred ? "有" : "無",
    record.opponentReverseOccurred ? "有" : "無",
    record.mySelfDestructOccurred ? "有" : "無",
    record.opponentSelfDestructOccurred ? "有" : "無",
    ...beyValues(record.myBey),
    ...beyValues(record.opponentBey),
    record.note
  ]);
  const csv = [header, ...rows].map(row => row.map(csvEscape).join(",")).join("\r\n");
  download(`\uFEFF${csv}`, `BeyLogX_${dateStamp()}.csv`, "text/csv;charset=utf-8");
  showToast("CSVを書き出しました");
}

async function deleteRecord(id) {
  try {
    await BattleDatabase.remove(id);
    records = records.filter(record => record.id !== id);
    renderAllDataViews();
    showToast("対戦記録を削除しました");
  } catch (error) {
    console.error(error);
    showToast("削除できませんでした");
  }
}

async function configurePersistentStorage() {
  const status = $("#storage-status");
  const detail = $("#persistence-detail");
  if (!navigator.storage?.persist) {
    status.textContent = "端末内へ自動保存";
    detail.textContent = "ブラウザ管理";
    return;
  }
  try {
    let persisted = await navigator.storage.persisted();
    if (!persisted) persisted = await navigator.storage.persist();
    status.textContent = persisted ? "永続ストレージで自動保存" : "端末内へ自動保存";
    detail.textContent = persisted ? "許可済み" : "ブラウザ管理（JSON保存推奨）";
  } catch {
    status.textContent = "端末内へ自動保存";
    detail.textContent = "ブラウザ管理（JSON保存推奨）";
  }
}

function bindEvents() {
  $("#battle-form").addEventListener("submit", saveBattle);
  $("#swap-sides").addEventListener("click", swapBattleSides);
  $("#favorite-select").addEventListener("change", event => {
    renderFavoriteControls(event.target.value);
    const favorite = favorites.find(item => item.id === event.target.value);
    if (favorite) $("#favorite-name").value = favorite.name;
  });
  $("#favorite-save-my").addEventListener("click", () => saveFavorite("my"));
  $("#favorite-save-opponent").addEventListener("click", () => saveFavorite("opponent"));
  $("#favorite-apply-my").addEventListener("click", () => applyFavorite("my"));
  $("#favorite-apply-opponent").addEventListener("click", () => applyFavorite("opponent"));
  $("#favorite-delete").addEventListener("click", deleteFavorite);
  $("#open-advantage").addEventListener("click", () => showView("advantage"));
  $("#advantage-back").addEventListener("click", () => showView("analysis"));
  $("#advantage-sort").addEventListener("change", renderAdvantage);
  $$(".bottom-nav button").forEach(button => button.addEventListener("click", () => showView(button.dataset.view)));

  $("#data-menu-button").addEventListener("click", event => {
    event.stopPropagation();
    const menu = $("#data-menu");
    const open = menu.hidden;
    menu.hidden = !open;
    $("#data-menu-button").setAttribute("aria-expanded", String(open));
  });
  document.addEventListener("click", () => {
    $("#data-menu").hidden = true;
    $("#data-menu-button").setAttribute("aria-expanded", "false");
  });
  $("#data-menu").addEventListener("click", event => event.stopPropagation());

  document.addEventListener("click", event => {
    const actionButton = event.target.closest("[data-action]");
    if (actionButton) {
      const action = actionButton.dataset.action;
      if (action === "export-json") exportJSON();
      if (action === "import-json") $("#json-file-input").click();
      if (action === "export-csv") exportCSV();
      $("#data-menu").hidden = true;
    }
    const deleteButton = event.target.closest("[data-delete-id]");
    if (deleteButton) {
      deleteCandidateID = deleteButton.dataset.deleteId;
      $("#confirm-dialog").showModal();
    }
  });
  $("#json-file-input").addEventListener("change", event => {
    const file = event.target.files?.[0];
    if (file) importJSONFile(file);
  });
  $("#confirm-dialog").addEventListener("close", () => {
    if ($("#confirm-dialog").returnValue === "confirm" && deleteCandidateID) {
      deleteRecord(deleteCandidateID);
    }
    deleteCandidateID = null;
  });
}

async function start() {
  renderConfiguration("my-config", states.my);
  renderConfiguration("opponent-config", states.opponent);
  renderConfiguration("analysis-config", states.analysis, { analysis: true });
  renderFavoriteControls();
  setInitialDate();
  bindEvents();

  try {
    db = await BattleDatabase.open();
    const [storedRecords, storedFavorites] = await Promise.all([
      BattleDatabase.all(),
      BattleDatabase.allFavorites()
    ]);
    records = storedRecords.map(normalizedRecord);
    favorites = storedFavorites.map(normalizeFavorite);
    renderFavoriteControls();
    renderAllDataViews();
    await configurePersistentStorage();
  } catch (error) {
    console.error(error);
    $("#storage-status").textContent = "保存領域エラー";
    $("#persistence-detail").textContent = "利用できません";
    showToast("ブラウザの保存領域を利用できません");
  }

  if ("serviceWorker" in navigator && location.protocol !== "file:") {
    let reloadingForUpdate = false;
    navigator.serviceWorker.addEventListener("controllerchange", () => {
      if (reloadingForUpdate) return;
      reloadingForUpdate = true;
      location.reload();
    });
    navigator.serviceWorker.register("./sw.js", { updateViaCache: "none" })
      .then(registration => registration.update())
      .catch(console.error);
  }
}

start();
