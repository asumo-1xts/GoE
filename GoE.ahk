#Requires AutoHotkey v2.0
#Include vendor/IMEv2.ahk

global spaceMode := 0

#HotIf WinActive("ahk_exe WindowsTerminal.exe")

; Ctrl+SpaceでIME状態を取得
^Space:: {
    global spaceMode
    imeState := IME_GET("A")
    if (imeState) {
        spaceMode := 1
    } else {
        spaceMode := 0
    }
}

; Spaceキーの挙動をIME状態に応じて変更
$Space:: {
    global spaceMode
    if (spaceMode == 1) {
        Send("1")
    } else {
        Send("0")
    }
}

#HotIf