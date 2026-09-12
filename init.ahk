#Requires AutoHotkey v2.0

#Include vendor/JSON.ahk

A_IconTip := "GoE"
configFile := "config.json"

if FileExist(configFile) {
    ; JSONファイルを読み込む
    fileContent := FileRead(configFile, "UTF-8")
    configData := JSON.parse(fileContent)

    ; スタートアップ設定
    if (configData.Has("startup")) {
        ; スタートアップフォルダ内のショートカットパス
        shortcutPath := A_Startup . "\" . A_IconTip . ".lnk"

        if (configData["startup"]) {
            ; ショートカットが存在しない場合、作成して追加
            if !FileExist(shortcutPath) {
                FileCreateShortcut(A_ScriptFullPath, shortcutPath)
            }
        } else {
            ; ショートカットが存在する場合、削除
            if FileExist(shortcutPath) {
                FileDelete(shortcutPath)
            }
        }
    }

    ; 対象アプリを追加
    if configData.Has("apps") {
        for app in configData["apps"] {
            GroupAdd("TargetApps", "ahk_exe " . app)
        }
    }
}
