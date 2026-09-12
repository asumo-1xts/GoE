<h1 align="center">
  The God of Enter
</h1>

<div align="center">
  <b>👼Enterの神様👼</b>
  <p>チャットアプリにおいてEnterキーによる誤送信を撲滅するための常駐アプリ</p>

| 操作       | Before            | After            |
| ---------- | ----------------- | ---------------- |
| 変換を確定 | `Enter`           | `Enter`          |
| 改行       | `Shift` + `Enter` | `Enter`          |
| 送信       | `Enter`           | `Ctrl` + `Enter` |

</div>

## 対応環境

- Windows 11
  - Microsoft IME

デフォルト設定での対応アプリは下記の通りです。

- Discord

`config.json`内の`apps`にて対応アプリの追加・削除が可能です。\
`GoE.exe`を再起動することで設定が反映されます。

## インストールと実行

1. [Release](https://github.com/asumo-1xts/GoE/releases)から`GoE.zip`をダウンロードして、適当なフォルダに展開
2. `GoE.exe`を実行🎉

デフォルト設定では、次回のPC起動時から自動で`GoE.exe`が実行されるようになります。\
これを無効化したい場合は、`config.json`内の`"startup"`を`false`にしてください。
