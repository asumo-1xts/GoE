#Requires AutoHotkey v2.0
#SingleInstance Force

#Include vendor/JSON.ahk
#Include vendor/IMEv2.ahk
#Include src/Config.ahk
#Include src/TargetMatcher.ahk
#Include src/ImeEnterController.ahk

A_IconTip := "GoE"
SetTitleMatchMode(2)    ; ウィンドウタイトルを部分一致で判定する

cfg := Config("config.json")
cfg.ApplyStartup(A_IconTip)

matcher := TargetMatcher(cfg.apps, cfg.sites)
ImeEnterController(matcher)