<h1 align="center">
  The God of Enter <img src="../assets/GoE.ico" alt="GoE Icon" width="35" height="35">
</h1>

<div align="center">
  <b>Enterの神様</b>
  <p>👼</p>
  <p>Enterキーによる誤送信を撲滅するためのWindows常駐アプリ</p>

| 操作       | Before            | After            |
| ---------- | ----------------- | ---------------- |
| 変換を確定 | `Enter`           | `Enter`          |
| 改行       | `Shift` + `Enter` | `Enter`          |
| 送信       | `Enter`           | `Ctrl` + `Enter` |

</div>

## インストールと実行

1. [Release](https://github.com/asumo-1xts/GoE/releases)から`GoE-v*.zip`をダウンロードして、適当なフォルダに展開
2. `GoE.exe`を実行🎉
3. 各種メニューはタスクトレイの🪽アイコンを右クリック

デフォルト設定では、次回のPC起動時から自動で`GoE.exe`が立ち上がるようになります。\
これを無効化したい場合は、`config.json`内の`"startup"`を`false`にしてください。

## 対応環境

**Windows 11 + Microsoft IME**

### デスクトップアプリ

- Discord
- Teams
- M365 Copilot

### Webアプリ

- Discord
- Teams
- X（DM）
- ChatGPT
- M365 Copilot
- Gemini

---

`config.json`内の`apps`および`sites`にてアプリの追加・削除が可能です。\
`GoE.exe`を再起動することで設定が反映されます。
