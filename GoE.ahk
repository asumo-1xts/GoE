#Requires AutoHotkey v2.0
#SingleInstance Force

#Include vendor/JSON.ahk
#Include src/Initialize.ahk
#Include src/ImeEnterController.ahk
#Include src/SetTaskTray.ahk
#Include src/TargetMatcher.ahk

A_IconTip := "The God of Enter" ; トレイアイコンの表示名
SetTitleMatchMode(2)            ; ウィンドウタイトルを部分一致で判定する設定

config := Initialize("config.json")                 ; 設定をロード
config.ApplyStartup("GoE")                          ; スタートアップ設定を適用
matcher := TargetMatcher(config.apps, config.sites) ; 対応するターゲットを把握
ImeEnterController(matcher)                         ; 本編開始
