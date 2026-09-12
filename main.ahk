#Requires AutoHotkey v2.0
#SingleInstance Force

#Include vendor/JSON.ahk
#Include vendor/IMEv2.ahk
#Include src/Config.ahk
#Include src/ImeEnterController.ahk
#Include src/SetTaskTray.ahk
#Include src/TargetMatcher.ahk

A_IconTip := "GoE"      ; このアプリの内部的な名前
SetTitleMatchMode(2)    ; ウィンドウタイトルを部分一致で判定する

cfg := Config("config.json")    ; 設定を読み込む
cfg.ApplyStartup(A_IconTip)     ; 設定を適用

matcher := TargetMatcher(cfg.apps, cfg.sites)
ImeEnterController(matcher) ; 本編開始
