$themeUrls = @{
    "twilite.json"        = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite.json"
    "twilite-darker.json" = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite-darker.json"
}

# For user level:
# $themeDir = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments\Twilite"
$themeDir = "C:\ProgramData\Microsoft\Windows Terminal\Fragments\Twilite"

New-Item -ItemType Directory -Force -Path $themeDir | Out-Null

foreach ($name in $themeUrls.Keys) {
    $url = $themeUrls[$name]
    $dest = Join-Path $themeDir $name
    Invoke-WebRequest -Uri $url -OutFile $dest
}
