$themeUrls = @{
    "twilite.json"        = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite.json"
    "twilite-darker.json" = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite-darker.json"
}

# Only set themeDir if it isn't already defined
if (-not $themeDir) {
    # System‑wide default
    $themeDir = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments\Twilite"
}


Remove-Item -Recurse -Force -Path $themeDir -ErrorAction SilentlyContinue

New-Item -ItemType Directory -Force -Path $themeDir | Out-Null

foreach ($name in $themeUrls.Keys) {
    $url = $themeUrls[$name]
    $dest = Join-Path $themeDir $name
    Invoke-WebRequest -Uri $url -OutFile $dest
}
