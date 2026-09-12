#Requires AutoHotkey v2.0

; アクティブなウィンドウが有効化の対象かどうかを判定するクラス
class TargetMatcher {
    static siteGroup := "GoETargetSites"

    __New(apps, sites) {
        this.apps := apps
        this.hasSites := sites.Length > 0

        ; Webサイト（ウィンドウタイトル）をグループへ登録
        for site in sites {
            GroupAdd(TargetMatcher.siteGroup, site)
        }
    }

    IsActive() {
        ; デスクトップアプリの判定
        for exe in this.apps {
            if WinActive("ahk_exe " exe) {
                return true
            }
        }

        ; Webサイトの判定
        if (this.hasSites && WinActive("ahk_group " TargetMatcher.siteGroup)) {
            return true
        }

        return false
    }
}
