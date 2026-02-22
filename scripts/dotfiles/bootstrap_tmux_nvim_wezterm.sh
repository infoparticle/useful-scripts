# installs tmux,nvim and wezterm config files
# bash -c $(curl -sSL curl -sSL https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles/bootstrap_tmux_nvim_wezterm.sh) 
#

######## nvim ########
mkdir ~/.config/nvim -p
curl -sSL https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles/tools.editor.vim/dot_config_nvim.lua > ~/.config/nvim/init.lua

######## tmux ########
curl -sSL https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles/tools.tmux/dot_tmux.conf > ~/.tmux.conf

######## wezterm ########
curl -sSL https://raw.githubusercontent.com/infoparticle/useful-scripts/refs/heads/main/scripts/dotfiles/tools.terminal/dot_wezterm.lua > ~/.wezterm.lua

