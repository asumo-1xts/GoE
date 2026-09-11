#Requires AutoHotkey v2.0

; ========== 外部ファイルからの読み込み処理 ==========

listFile := "apps.txt"

if FileExist(listFile) {
    ; ファイルからテキストを読み込み、改行コードで1行ずつ分割
    fileContent := FileRead(listFile, "UTF-8")

    for processName in StrSplit(fileContent, "`n", "`r") {
        ; 空白行や空文字を除外してグループに追加
        processName := Trim(processName)
        if (processName != "") {
            GroupAdd("TargetApps", "ahk_exe " . processName)
        }
    }
} else {
    GroupAdd("TargetApps", "") ; 存在しないダミーアプリを追加
}
