# 1. Configuration
let url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip"
let install_dir = "C:/opt"
let bin_dir = ($install_dir | path join "nvim-win64/bin")
let zip_file = ($env.TEMP | path join "nvim.zip")

if not ($install_dir | path exists) { mkdir $install_dir }

print "Downloading Neovim..."
http get $url | save $zip_file --force
unzip $zip_file -d $install_dir

let registry_path = (powershell -command "[Environment]::GetEnvironmentVariable('Path', 'User')")

if ($registry_path | str contains $bin_dir) {
    print "Path already exists in Windows Registry."
} else {
    print "Adding to Windows User Registry PATH..."
    let new_path = $"($registry_path);($bin_dir)"

    # 1. Build the PowerShell command string first
    let ps_cmd = $"[Environment]::SetEnvironmentVariable\('Path', '($new_path)', 'User'\)"

    # 2. Execute it
    powershell -command $ps_cmd
    
    print "Registry updated! Open a NEW CMD or PowerShell window to use 'nvim'."
}

rm $zip_file
