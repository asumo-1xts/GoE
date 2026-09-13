# エラーが発生したら即停止
$ErrorActionPreference = "Stop"

# 1. Ahk2Exeでコンパイル
powershell -File "scripts\convert.ps1"

# 2. 圧縮対象の存在チェック
$targets = @("GoE.exe", "config.json")
foreach ($target in $targets) {
    if (-not (Test-Path $target)) {
        Write-Error "Required file/folder missing: $target"
        exit 1
    }
}

# 3. ZIP圧縮
Write-Host "Packaging..." -ForegroundColor Cyan
Compress-Archive -Path $targets -DestinationPath "GoE.zip" -Force
Write-Host "Done." -ForegroundColor Cyan