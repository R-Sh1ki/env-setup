winget.exe install --id Starship.Starship
winget.exe install --id Microsoft.Powershell --source winget
if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }
Copy-Item .\Microsoft.PowerShell_profile.ps1 $PROFILE -Force