# installs tmux,nvim and wezterm config files
# bash -c $(curl -sSL curl -sSL https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles/bootstrap_tmux_nvim_wezterm.sh) 
#

# Generate a single timestamp for this execution run
TS=$(date +%Y%m%d_%H%M%S)
BASE_URL="https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles"

echo "Starting environment bootstrap at $TS..."

backup_and_install() {
    local target_file=$1
    local url=$2
    local target_dir=$(dirname "$target_file")

    # Ensure the parent directory exists
    mkdir -p "$target_dir"

    # Safely park the old state if it exists
    if [[ -f "$target_file" ]]; then
        local backup_path="${target_file}.${TS}"
        echo "--> Backing up existing $target_file to $backup_path"
        mv "$target_file" "$backup_path"
    fi

    echo "--> Downloading config to $target_file..."
    # -f fails silently on server errors, -s hides progress bar, -S shows errors, -L follows redirects
    # -o writes directly to the file safely
    curl -fsSL -o "$target_file" "$url"
    if [[ $? -eq 0 ]]; then    
        echo "--> Successfully installed $target_file"
    else
        echo "ERROR: curl to fetch $url failed"
    fi
    echo "----------------------------------------"
}

# Execute the installations
backup_and_install "$HOME/.config/nvim/init.lua" "$BASE_URL/tools.editor.vim/dot_config_nvim_init.lua"
backup_and_install "$HOME/.tmux.conf" "$BASE_URL/tools.tmux/dot_tmux.conf"
backup_and_install "$HOME/.wezterm.lua" "$BASE_URL/tools.terminal/dot_wezterm.lua"

echo "Bootstrap complete. Fire up your terminal."
