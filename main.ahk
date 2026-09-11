#Requires AutoHotkey v2.0

#Include load_apps.ahk      ; 対象アプリをロード
#Include vendor/IMEv2.ahk   ; IME操作ライブラリ

global recChar := false     ; 既に何らかの文字があるか否か

#HotIf WinActive("ahk_group TargetApps")

; 1文字キーが押されたらフラグを立てる
for key in StrSplit("abcdefghijklmnopqrstuvwxyz0123456789")
    Hotkey("~*" key, ResetrecEnter)

ResetrecEnter(*) {
    global recChar
    recChar := true
}

; 条件に応じたEnterキーの挙動
$Enter:: {
    global recChar

    ; IME=ONかつ既に何らかの文字がある？
    if (IME_GET("A") && recChar) {
        Send("{Enter}") ; YES => Enterで変換を確定
    } else {
        Send("+{Enter}") ; NO => Shift+Enterで改行
    }

    recChar := false
}

; 無条件にCtrl+Enterで確定または送信
^Enter:: {
    global recChar

    Send("{Enter}")

    recChar := false
}

#HotIf