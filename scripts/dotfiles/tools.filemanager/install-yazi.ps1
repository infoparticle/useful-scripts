# Define variables
$yaziVersion = "v26.1.22"
$url = "https://github.com/sxyazi/yazi/releases/download/$yaziVersion/yazi-x86_64-pc-windows-msvc.zip"

$zipPath = "$env:TEMP\yazi-win.zip"
$installDir = "C:\opt\tools\terminal"
$binPath = "$installDir\yazi-x86_64-pc-windows-msvc"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir
}

Write-Host "Downloading yazi $yaziVersion..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $zipPath

Write-Host "Extracting to $installDir..." -ForegroundColor Cyan
Expand-Archive -Path $zipPath -DestinationPath $installDir -Force

Write-Host "Updating PATH variable..." -ForegroundColor Cyan
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$binPath*") {
    $newPath = "$currentPath;$binPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "PATH : $newPath - updated successfully. Please restart your terminal." -ForegroundColor Green
} else {
    Write-Host "PATH : $newPath - already contains the yazi bin directory." -ForegroundColor Yellow
}

Remove-Item $zipPath
