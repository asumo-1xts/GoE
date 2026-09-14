#Requires AutoHotkey v2.0

; デフォルト設定を保持しておく
DefaultConfigJson := FileRead("config.json")

; 標準メニュー項目をすべて削除
A_TrayMenu.Delete()

; 独自メニュー項目の追加
A_TrayMenu.Add("設定", Menu_OpenConfig)
A_TrayMenu.Add()
A_TrayMenu.Add("情報", Menu_OpenInfo)
A_TrayMenu.Add()
A_TrayMenu.Add("再起動", Menu_Restart)
A_TrayMenu.Add()
A_TrayMenu.Add("終了", Menu_Exit)

; タスクトレイアイコンへの通知メッセージ（0x404）をフック
OnMessage(0x404, AHK_NOTIFYICON)

AHK_NOTIFYICON(wParam, lParam, msg, hwnd) {
    ; 0x202 = WM_LBUTTONUP（左ボタンを離した瞬間）
    if (lParam = 0x202) {
        Menu_OpenConfig("", "", "")
        return 0
    }
}

Menu_OpenConfig(ItemName, ItemPos, MyMenu) {
    if !FileExist("config.json") {
        FileAppend(DefaultConfigJson, "config.json")
    }

    Run("config.json")
}

Menu_OpenInfo(ItemName, ItemPos, MyMenu) {
    Run("https://github.com/asumo-1xts/GoE")
}

Menu_Restart(ItemName, ItemPos, MyMenu) {
    Reload()
}

Menu_Exit(ItemName, ItemPos, MyMenu) {
    ExitApp()
}
