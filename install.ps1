<#
.SYNOPSIS
    Installs the Twilite theme profiles for Windows Terminal.

.DESCRIPTION
    This function downloads and creates fragment files for the Twilite and Twilite Darker themes.
    The fragment files add the color schemes to Windows Terminal.

.EXAMPLE
    .\install.ps1

    This command installs the Twilite theme profiles for Windows Terminal.

.NOTES
    The fragment files are created in the LocalAppData directory for Windows Terminal.
    After running this script, restart Windows Terminal to see the new themes.
#>

function Install-TwiliteThemes {
    # Define the path for the fragment directory
    $fragmentDir = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments\Twilite"

    # Ensure the directory exists
    if (-not (Test-Path -Path $fragmentDir)) {
        New-Item -ItemType Directory -Path $fragmentDir -Force
    }

    # Download and parse the Twilite color schemes
    $themeUrls = @{
        "twilite.json" = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite.json"
        "twilite-darker.json" = "https://raw.githubusercontent.com/vegcom/WindowsTerminal-Twilite/refs/heads/main/twilite-darker.json"
    }

    $schemes = @{}
    foreach ($themeFile in $themeUrls.Keys) {
        try {
            $schemes[$themeFile] = Invoke-RestMethod -Uri $themeUrls[$themeFile]
            Write-Host "Successfully downloaded $themeFile"
        } catch {
            Write-Error "Failed to download ${themeFile}e}: $_"
            exit 1
        }
    }

    # Create the fragment files for both themes
    foreach ($themeFile in $themeUrls.Keys) {
            $fragmentContent = @{
                schemes = @($schemes[$themeFile])
                profiles = @{
                    defaults = @{
                        colorScheme = $schemes[$themeFile].name
                    }
                }
            }

            # Convert to JSON and save to the fragment file
            $fragmentContent | ConvertTo-Json -Depth 32 | Set-Content -Path "$fragmentDir\$themeFile"
        }
    }


Write-Host "Twilite themes have been installed successfully!" -ForegroundColor Green

# Done
Write-Host "Fragment files created at: $fragmentDir"
Write-Host "Restart Windows Terminal to see the new themes."


# Call the function to install the Twilite themes
Install-TwiliteThemes
