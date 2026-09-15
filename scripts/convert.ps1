# config.jsonを取得して、DefaultConfigJson.ahkの中身を作成
$json = Get-Content config.json -Raw

$content = @"
#Requires AutoHotkey v2.0

DefaultConfigJson := "
(
$json
)"
"@

# リセットしたDefaultConfigJson.ahkファイルにコピペ
New-Item src\DefaultConfigJson.ahk -ItemType File -Force | Out-Null
Set-Content src\DefaultConfigJson.ahk $content -Encoding UTF8

# .exeファイルを生成
& "$env:LOCALAPPDATA\Programs\AutoHotkey\Compiler\Ahk2Exe.exe" `
  /in "GoE.ahk" `
  /out "GoE.exe" `
  /icon "assets\GoE.ico" `
  /base "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"