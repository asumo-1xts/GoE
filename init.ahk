#Requires AutoHotkey v2.0
#Include vendor/JSON.ahk

A_IconTip := "GoE"
configFile := "config.json"

global targetApps := []
SetTitleMatchMode(2) ; 部分一致でウィンドウタイトルを判定するための呪文

if FileExist(configFile) {
    ; 設定ファイルの読み込み
    fileContent := FileRead(configFile, "UTF-8")
    configData := JSON.parse(fileContent)

    ; スタートアップ設定
    shortcutPath := A_Startup . "\" . A_IconTip . ".lnk"

    if (configData.Has("startup") && configData["startup"]) {
        ; スタートアップが有効かつショートカットが存在しない場合は作成
        if !FileExist(shortcutPath) {
            FileCreateShortcut(A_ScriptFullPath, shortcutPath)
        }
    } else {
        ; スタートアップが無効かつショートカットが存在する場合は削除
        if FileExist(shortcutPath) {
            FileDelete(shortcutPath)
        }
    }

    ; 対象アプリの一覧を取得
    if configData.Has("apps") {
        for app in configData["apps"] {
            targetApps.Push(app)
        }
    }

    ; 対象Webサイト名（ウィンドウタイトル）の一覧を取得してグループに追加
    if configData.Has("sites") {
        for site in configData["sites"] {
            if (site != "") {
                GroupAdd("TargetSites", site)
            }
        }
    }
} else {
    ; 設定ファイルが存在しない場合は空のグループを作成
    GroupAdd("TargetSites", "")
}

; 有効化の是非を判定する関数
IsTargetActive() {
    ; デスクトップアプリの判定
    for exe in targetApps {
        if WinActive("ahk_exe " . exe) {
            return true
        }
    }

    ; Webサイトの判定
    if WinActive("ahk_group TargetSites") {
        return true
    }

    return false
}
