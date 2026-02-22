# Define variables
$wezVersion = "20240203-110809-5046fc22"
$url = "https://github.com/wezterm/wezterm/releases/download/$wezVersion/WezTerm-windows-$wezVersion.zip"
$zipPath = "$env:TEMP\WezTerm-windows-$wezVersion.zip"
$installDir = "C:\opt\tools\terminal"
$binPath = "$installDir\WezTerm-windows-$wezVersion"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir
}

Write-Host "Downloading WezTerm $wezVersion build..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $zipPath

Write-Host "Extracting to $installDir..." -ForegroundColor Cyan
Expand-Archive -Path $zipPath -DestinationPath $installDir -Force

Write-Host "Updating PATH variable..." -ForegroundColor Cyan
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$binPath*") {
    $newPath = "$currentPath;$binPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "PATH updated successfully. Please restart your terminal." -ForegroundColor Green
} else {
    Write-Host "PATH already contains the WezTerm bin directory." -ForegroundColor Yellow
}

Remove-Item $zipPath
