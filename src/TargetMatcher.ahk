#Requires AutoHotkey v2.0

#Include ../vendor/UIA_fixed.ahk

/**
 * @class TargetMatcher
 * @description アクティブなウィンドウおよびUIA要素が有効化の対象かどうかを判定するクラス
 */
class TargetMatcher {
    static siteGroup := "GoETargetSites"

    __New(apps, sites) {
        this.apps := apps
        this.sites := sites
        this.hasSites := sites.Length > 0
    }

    /**
     * @function IsActive
     * @description ウィンドウおよびブラウザのURLから対象かどうかを判定
     * @return true: 対象 / false: 非対象
     */
    IsActive() {
        hwnd := WinActive("A")

        if !hwnd {
            return false
        }

        ; デスクトップアプリの判定
        for exe in this.apps {
            if WinActive("ahk_exe " exe) {
                return true
            }
        }

        ; UIAを使用したブラウザのURL判定
        if (this.hasSites && this.IsTargetUrl(hwnd)) {
            return true
        }

        return false
    }

    /**
     * @function IsTargetUrl
     * @description UIA経由でブラウザのアドレスバーからURLを取得・検証
     * @param hwnd 対象ウィンドウのハンドル
     * @return true: 対象URL / false: 非対象URL
     */
    IsTargetUrl(hwnd) {
        try {
            ; アクティブウィンドウのUIA要素を取得
            el := UIA.ElementFromHandle(hwnd)

            ; アドレスバー（Editコントロール）を取得
            addressBar := el.FindElement({ Type: "Edit" })

            if addressBar {
                url := addressBar.Value
                for site in this.sites {
                    if InStr(url, site) {
                        return true
                    }
                }
            }
        } catch {
            return false ; UIA取得失敗時のエラーを防止
        }
        return false
    }
}
