#Requires AutoHotkey v2.0

; 出典：https://qiita.com/kenichiro_ayaki/items/d55005df2787da725c6f#31-ime_get-

;-----------------------------------------------------------
; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF
;-----------------------------------------------------------
IME_GET(WinTitle := "A") {
    hwnd := WinExist(WinTitle)
    if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        cbSize := 4 + 4 + (PtrSize * 6) + 16
        stGTI := Buffer(cbSize, 0)
        NumPut("DWORD", cbSize, stGTI.Ptr, 0)   ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", "Uint", 0, "Uint", stGTI.Ptr)
            ? NumGet(stGTI.Ptr, 8 + PtrSize, "Uint") : hwnd
    }
    return DllCall("SendMessage"
        , "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hwnd)
        , "UInt", 0x0283  ;Message : WM_IME_CONTROL
        , "Int", 0x0005  ;wParam  : IMC_GETOPENSTATUS
        , "Int", 0)      ;lParam  : 0
}
