# Define variables
$rgVersion = "15.1.0"
$url = "https://github.com/BurntSushi/ripgrep/releases/download/$rgVersion/ripgrep-$rgVersion-x86_64-pc-windows-msvc.zip"
$zipPath = "$env:TEMP\RipGrep-windows-$rgVersion.zip"
$installDir = "C:\opt\tools\terminal"
$binPath = "$installDir\ripgrep-$rgVersion-x86_64-pc-windows-msvc"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir
}

Write-Host "Downloading RipGrep $rgVersion build..." -ForegroundColor Cyan
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
    Write-Host "PATH already contains the RipGrep bin directory." -ForegroundColor Yellow
}

Remove-Item $zipPath
