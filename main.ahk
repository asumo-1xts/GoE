#Requires AutoHotkey v2.0

#Include load_apps.ahk      ; 対象アプリをロード（完結）
#Include vendor/IMEv2.ahk   ; IME操作ライブラリ

ImeEnterController()        ; インスタンスを生成して実行

class ImeEnterController {
    hasChar := false        ; 既に何らかの文字があるか否かのフラグ

    __New() {
        HotIfWinActive("ahk_group TargetApps")

        ; 1文字キーが押されたらフラグを立てる
        for key in StrSplit("abcdefghijklmnopqrstuvwxyz0123456789") {
            Hotkey("~*" key, (*) => this.hasChar := true)
        }

        ; Enterキーの挙動を定義
        Hotkey("$Enter", (*) => this.OnEnter())
        Hotkey("^Enter", (*) => this.OnCtrlEnter())

        HotIf()
    }

    OnEnter() {
        if (IME_GET("A") && this.hasChar) {
            Send("{Enter}")
        } else {
            Send("+{Enter}")
        }
        this.hasChar := false
    }

    OnCtrlEnter() {
        Send("{Enter}")
        this.hasChar := false
    }
}
