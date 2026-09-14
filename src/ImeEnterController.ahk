#Requires AutoHotkey v2.0

#Include ./GetIME.ahk

/**
 * @class ImeEnterController
 * @description Enterキーの挙動を差し替えるコントローラー
 */
class ImeEnterController {
    hasChar := false

    __New(matcher) {
        this.matcher := matcher

        HotIf((*) => matcher.IsActive())

        alphabets := "abcdefghijklmnopqrstuvwxyz"
        numbers := "0123456789"
        symbols := "`-`=`[`]`\`;\`',`./````"

        ; 1文字キーの挙動を定義
        for key in StrSplit(alphabets . numbers . symbols) {
            ; 文字扱いしてよいもの：スルーして後処理
            Hotkey("~" key, (*) => this.OnChar())
            Hotkey("~+" key, (*) => this.OnChar())

            ; Ctrl+文字：スルーせずホットキー名を受け取る
            Hotkey("^" key, (hk) => this.OnCtrlChar(hk))
        }

        ; Enterキーの挙動を定義
        Hotkey("$Enter", (*) => this.OnEnter())
        Hotkey("^Enter", (*) => this.OnCtrlEnter())

        HotIf()
    }

    ; 未確定文字があるかどうかを判定する
    IsConfirmed() {
        return IME_GET("A") && this.hasChar
    }

    OnChar() {
        this.hasChar := IME_GET("A")
    }

    OnCtrlChar(hk) {
        ; 未確定文字があるときは何もしない
        ; 主にCtrl+Aでカーソルが行頭に移動するのを防ぐため
        if !this.IsConfirmed() {
            Send("{Blind}" . SubStr(hk, 2))
        }
    }

    OnEnter() {
        Send(this.IsConfirmed() ? "{Enter}" : "+{Enter}")
        this.hasChar := false
    }

    OnCtrlEnter() {
        Send("{Enter}")
        this.hasChar := false
    }
}
