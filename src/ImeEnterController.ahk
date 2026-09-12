#Requires AutoHotkey v2.0

#Include ../vendor/IMEv2.ahk

; Enterキーの挙動を差し替えるコントローラー
class ImeEnterController {
    hasChar := false

    __New(matcher) {
        this.matcher := matcher

        HotIf((*) => matcher.IsActive())

        ; 1文字キーの挙動を定義
        for key in StrSplit("abcdefghijklmnopqrstuvwxyz0123456789") {
            Hotkey("~" key, (*) => this.OnChar())       ; 文字のみ
            Hotkey("~+" key, (*) => this.OnChar())      ; Shift+文字
            Hotkey("~^" key, (*) => this.OnCtrlChar())  ; Ctrl+文字
        }

        ; Enterキーの挙動を定義
        Hotkey("$Enter", (*) => this.OnEnter())
        Hotkey("^Enter", (*) => this.OnCtrlEnter())

        HotIf()
    }

    ; Shift以外の修飾キーが押されている場合、1文字入力とは見做さない
    OnChar() {
        this.hasChar := IME_GET("A")
    }

    OnCtrlChar() {
        this.hasChar := false
    }

    OnEnter() {
        Send((IME_GET("A") && this.hasChar) ? "{Enter}" : "+{Enter}")
        this.hasChar := false
    }

    OnCtrlEnter() {
        Send("{Enter}")
        this.hasChar := false
    }
}
