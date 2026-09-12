#Requires AutoHotkey v2.0

#Include ../vendor/JSON.ahk

; config.json を読み込み、設定値を保持するクラス
class Config {
    startup := false
    apps := []
    sites := []

    __New(path) {
        if !FileExist(path) {
            return
        }

        ; 設定ファイルを読み込む
        data := JSON.parse(FileRead(path, "UTF-8"))

        ; スタートアップ設定
        if data.Has("startup") {
            this.startup := data["startup"]
        } else {
            this.startup := false
        }

        ; デスクトップアプリ設定
        if data.Has("apps") {
            for app in data["apps"] {
                this.apps.Push(app)
            }
        }

        ; Webサイト設定
        if data.Has("sites") {
            for site in data["sites"] {
                if (site != "") {
                    this.sites.Push(site)
                }
            }
        }
    }

    ; スタートアップのショートカットを作成または削除する関数
    ApplyStartup(name) {
        shortcutPath := A_Startup "\" name ".lnk"

        if (this.startup) {
            if !FileExist(shortcutPath) {
                FileCreateShortcut(A_ScriptFullPath, shortcutPath)
            }
        } else if FileExist(shortcutPath) {
            FileDelete(shortcutPath)
        }
    }
}
