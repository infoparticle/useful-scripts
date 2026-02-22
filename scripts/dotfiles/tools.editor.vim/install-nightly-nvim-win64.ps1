# Define variables
$url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip"
$zipPath = "$env:TEMP\nvim-win64.zip"
$installDir = "C:\opt"
$binPath = "$installDir\nvim-win64\bin"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir
}

Write-Host "Downloading Neovim nightly build..." -ForegroundColor Cyan
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
    Write-Host "PATH already contains the Neovim bin directory." -ForegroundColor Yellow
}

Remove-Item $zipPath
