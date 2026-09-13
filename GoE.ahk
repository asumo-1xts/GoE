#Requires AutoHotkey v2.0
#SingleInstance Force

#Include vendor/JSON.ahk
#Include vendor/IMEv2.ahk
#Include src/Config.ahk
#Include src/ImeEnterController.ahk
#Include src/SetTaskTray.ahk
#Include src/TargetMatcher.ahk

A_IconTip := "The God of Enter" ; トレイアイコンの表示名
SetTitleMatchMode(2)            ; ウィンドウタイトルを部分一致で判定する設定

cfg := Config("config.json")                  ; 設定をロード
cfg.ApplyStartup("GoE")                       ; スタートアップ設定を適用
matcher := TargetMatcher(cfg.apps, cfg.sites) ; 対応するターゲットを把握
ImeEnterController(matcher)                   ; 本編開始
